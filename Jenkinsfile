pipeline {
  agent {
    docker {
      image '10.0.1.69:8123/jenkins-agent'
      args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
    }

  }

  stages {

    stage ('Copy sources') {
        steps {
            git(url: 'https://github.com/daticahealth/java-tomcat-maven-example', poll: true)
        }
    }

    stage ('build war') {
        steps {
            sh 'mvn package'
        }
    }

    stage ('Make docker image') {
        steps {
            //sh 'mkdir /home/docker'
            sh 'cp $(find -name "*.war") /home/docker'
            sh 'docker build -t 10.0.1.69:8123/myweb1 /home/docker/'
            sh 'docker tag myweb1 10.0.1.69:8123/myweb1'
            sh 'docker push 10.0.1.69:8123/myweb1'
        }
    }

    stage ('Pull docker image on remote host') {
        steps {
            sh 'ssh root@10.0.1.42 \'docker run -d -p 80:8081 10.0.1.69:8123/myweb1\''
        }
    }

  }
//  triggers {
//    pollSCM('*/1 H * * *')
//  }
}