def CONTAINER_NAME="hellowhale"
def CONTAINER_TAG="latest"
def DOCKER_HUB_USER="ndachuwa"
def HTTP_PORT="8090"

node {

    stage('Initialize'){
        echo "Initialized"
    }

    stage('Image Prune'){
        imagePrune(CONTAINER_NAME)
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
        }
    }
    
    
    stage('Run App'){
        runApp(HTTP_PORT)
    }

}

def imagePrune(containerName){
    try {
        sh "docker image prune -f"
        sh "docker stop $containerName"
    } catch(error){}
}

def imageBuild(containerName, tag){
    sh "cd /home/oracle/hellowhale"
    sh "docker build -t $containerName:$tag --pull --no-cache ."
    echo "Image build complete"
}


def pushToImage(containerName, tag, dockerUser, dockerPassword){
    sh "docker login -u $dockerUser -p $dockerPassword"
    sh "docker tag $containerName:$tag $dockerUser/$containerName:$tag"
    sh "docker push $dockerUser/$containerName:$tag"
    echo "Image push complete"
}

def runApp(httpPort){
    sh "docker pull ndachuwa/hellowhale"
    sh "docker run -d --rm -p 8090:8090 --name hellowhale ndachuwa/hellowhale:latest"
    echo "Application started on port: ${httpPort} (http)"
}
    
