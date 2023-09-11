node {
    stage("Pulling The Repository"){
        git url: "https://github.com/securin-demo/ecom-service.git"
    }
    stage("Artifact Build"){
        buildArtifact()
    }
}
def buildArtifact() {
    sh "mvn -U clean package -Darguments='-Dmaven.javadoc.skip=true'"
}
