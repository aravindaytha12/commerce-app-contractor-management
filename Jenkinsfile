pipeline {
  agent any
  environment {
    DOCKER_REGISTRY = 'https://quay.io/'
    APP_NAME = 'contractor-management'
  }
  options {
    ansiColor('xterm')
  }
  stages {
    stage('read git info') {
      steps {
        script {
          repoInfo()
        }
      }
    }
    stage('Validate the CHANGELOG') {
      steps {
        script {
          def semantic_version = ~/\bv?(?<major>[0-9]+)\.(?<minor>[0-9]+)\.(?<patch>[0-9]+)(?<pre>-[\w\.]+)?(?<meta>\+[\w\.]+)?\b/
          def parser = { changelog ->
            def matcher = changelog.split('\n').find { it =~ semantic_version } =~ semantic_version
            return matcher.find() ? matcher.group(0) : null
          }
          def this_version = parser(readFile('CHANGELOG.md'))
          if (!this_version) {
            error 'changelog needs a properly formatted version'
          }
          if (env.BRANCH_NAME != 'master') {
            master_files = sh(script: 'git ls-tree -z --name-only origin/master', returnStdout: true).trim().tokenize('\0')
            if (master_files.find { it == 'CHANGELOG.md' }) {
              def master_version = parser(sh(script: 'git show origin/master:CHANGELOG.md', returnStdout: true))
              echo "master version: ${master_version}\nok? ${master_version != this_version}"
              if (master_version == this_version) {
                error 'update the changelog'
              }
            }
          }
          env.CHANGELOG_VERSION = this_version
        }
      }
    }
    stage('build the docker container') {
      steps {
        script {
          if (env.BRANCH_NAME != 'master') {
            env.RELEASE_NAME = "${env.APP_NAME}-${env.BRANCH_NAME.toLowerCase()}"
            env.IMAGE_TAG = "${env.BRANCH_NAME}"
            env.ENVIRONMENT = 'development'
          } else {
            env.RELEASE_NAME = "${env.APP_NAME}"
            env.IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
            env.ENVIRONMENT = 'production-east'
          }
          docker.withRegistry(env.DOCKER_REGISTRY, 'quay') {
            env.IMAGE = "quay.io/gannett/contractor-management:${env.IMAGE_TAG}"
            docker.build(env.IMAGE, '--force-rm --pull .')
          }
        }
      }
    }

    // run the app tests...
    stage('Run unit tests') {
      environment {
        VAULT_TOKEN = readFile('/var/run/secrets/vault-volume/token')
      }
      steps {
        sh "docker run --rm -e VAULT_TOKEN ${env.IMAGE} docker-files/run-tests.sh"
      }
    }

    // push the valid container to quay.io
    stage('Push container') {
      steps {
        script {
          docker.withRegistry(env.DOCKER_REGISTRY, 'quay') {
            def image = docker.image(env.IMAGE)
            image.push()
          }
        }
      }
    }

    // deploy with helm using the helm job...
    stage('Deploy container using helm') {
      steps {
        build job: '/deployments/helm', parameters: [
          string(name: 'ENVIRONMENT', value: env.ENVIRONMENT),
          string(name: 'CHART_NAME', value: env.APP_NAME),
          string(name: 'RELEASE_NAME', value: env.RELEASE_NAME),
          string(name: 'IMAGE_TAG', value: env.IMAGE_TAG),
        ]
      }
    }

    stage('get service ip') {
      when {
        not {
          branch 'master'
        }
      }
      steps {
        script {
          sleep 30
          def credentials = 'secret/CommerceDevOps/kubernetes/commerce-solutions-circ-development-east-admin'
          kubectl.withVaultConfig(credentials) { namespace ->
            withEnv(["TILLER_NAMESPACE=${namespace}"]) {
              def serviceIpCmd = "kubectl get service/${env.RELEASE_NAME} -o jsonpath={.status.loadBalancer.ingress[0].ip}"
              env.DEV_SERVICE_IP = sh(returnStdout: true, script: serviceIpCmd).trim()
            }
          }
        }
      }
    }

    stage ('Clean up merged release') {
      when {
        branch 'master'
      }
      steps {
        script {
          def semantic_version = ~/Merge pull request #(\d+)/
          def gitlog = sh(script: 'git log -n 1', returnStdout: true).trim()
          def parser = { release ->
            def matcher = release.split('\n').find { it =~ semantic_version } =~ semantic_version
            return matcher.find() ? matcher[0][1] : null
          }
          env.RELEASE_NBR = parser(gitlog)
        }
        // clean up the merged release with the delete helm release job...
        build job: '/deployments/delete helm release', parameters: [
          string(name: 'RELEASE_NAME', value: "${env.APP_NAME}-pr-${env.RELEASE_NBR}")
        ]
      }
    }
  }

  post {
    always {
      script {
        def channel = [
          'development': '#cdv-dev-ci-builds',
          'production-east': '#cdv-prod-ci-builds',
          'production-west': '#cdv-prod-ci-builds'
        ][env.ENVIRONMENT]
        slackSend channel: channel,
                color: buildStatusColor(),
                message: "Deployment of `${env.RELEASE_NAME}` to `${env.ENVIRONMENT}` finished: *${currentBuild.currentResult.toLowerCase()}*" +
                         "\n<${env.JENKINS_URL}|commerce-solutions-jenkins:> <${env.BUILD_URL}|${env.JOB_NAME} #${env.BUILD_NUMBER}>" +
                         "\n The service IP is https://${env.DEV_SERVICE_IP}. Use this IP to test."
      }
    }
  }
}
