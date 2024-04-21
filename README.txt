// BuildKit run & install:
docker run --rm --privileged -d --name buildkit moby/buildkit

// Build: ("push=true" -> export to the GitHub packages)
DOCKER_BUILDKIT=1 docker buildx build \
  --ssh default \
  --platform linux/arm64 \
  --build-arg VERSION=12.2.2 \
  --build-arg SERVER_IP=$(hostname -I | awk '{print $1}') \
  --build-arg SERVER_NAME=$(hostname) \
  -t ghcr.io/mikk1max/lab6:latest \
  --output "type=image,name=ghcr.io/mikk1max/lab6,public=1,push=true" \
  .


// -> Dodatkowo:
/*
{
// Run:
docker run -d -p 8080:80 ghcr.io/mikk1max/lab6:latest

// Wynik (sprawdzenie curlem):
curl http://localhost:8080 
}
*/

# Maksym Shepeta