@Library('podTemplateLib')

import net.santiment.utils.podTemplates

slaveTemplates = new podTemplates()

slaveTemplates.dockerTemplate { label ->
  node(label) {
    container('docker') {
      def scmVars = checkout scm
      def imageName = "airflow-fork"

      stage('Build image') {
        withCredentials([string(credentialsId: 'aws_account_id', variable: 'aws_account_id')]) {
          def awsRegistry = "${env.aws_account_id}.dkr.ecr.eu-central-1.amazonaws.com"

          docker.withRegistry("https://${awsRegistry}", "ecr:eu-central-1:ecr-credentials") {
            sh "docker build . \
              -t ${awsRegistry}/${imageName}:${env.BRANCH_NAME} \
              -t ${awsRegistry}/${imageName}:${scmVars.GIT_COMMIT} \
              --build-arg PYTHON_BASE_IMAGE='python:3.8-slim-buster' \
              --build-arg AIRFLOW_VERSION='2.0.1' \
              --build-arg AIRFLOW_INSTALL_VERSION='2.0.1' \
              --build-arg AIRFLOW_INSTALLATION_METHOD='.' \
              --build-arg AIRFLOW_SOURCES_FROM='.' \
              --build-arg AIRFLOW_SOURCE_TO='/opt/airflow' \
              --build-arg INSTALL_FROM_PYPI='false'"
            sh "docker push ${awsRegistry}/${imageName}:${env.BRANCH_NAME}"
            sh "docker push ${awsRegistry}/${imageName}:${scmVars.GIT_COMMIT}"
          }
        }
      }
    }
  }
}
