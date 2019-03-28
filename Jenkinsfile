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

    stage('Run App'){
        runApp(HTTP_PORT)
    }

}

def imagePrune(containerName){
    try {
        sh "sudo docker image prune -f"
        sh "sudo docker stop $containerName"
    } catch(error){}
}

def imageBuild(containerName, tag){
    sh "sudo docker build -t $containerName:$tag  -t $containerName --pull --no-cache ."
    echo "Image build complete"
}

def pushToImage{
    sh "sudo docker login -u ndachuwa -p singakati123"
    sh "sudo docker tag hellowhale:latest ndachuwa/hellowhale:latest"
    sh "sudo docker push ndachuwa/hellowhale:latest"
    echo "Image push complete"
}

def runApp(httpPort){
    sh "sudo docker pull ndachuwa/hellowhale"
    sh "sudo docker run -d --rm -p 8090:8090 --name hellowhale ndachuwa/hellowhale:latest"
    echo "Application started on port: ${httpPort} (http)"
}
    
