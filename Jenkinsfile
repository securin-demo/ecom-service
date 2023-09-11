node {
    stage("Artifact Build"){
        buildArtifact()
    }
    
    def buildArtifact() {
        sh "mvn -U clean package -Darguments='-Dmaven.javadoc.skip=true'"
    }
}
