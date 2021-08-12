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

            sh "./breeze build-image --production-image --python 3.8  --installation-method .  \
                --image-tag ${awsRegistry}/${imageName}:${env.BRANCH_NAME}"
            sh "docker push ${awsRegistry}/${imageName}:${env.BRANCH_NAME}"
          }
        }
      }
    }
  }
}
