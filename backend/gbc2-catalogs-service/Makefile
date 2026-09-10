.PHONY: verify app-service functions app-run functions-run

verify:
	mvn -B clean verify

app-service:
	mvn -B -pl runtime-app-service -am clean package

functions:
	mvn -B -pl runtime-functions -am clean package

app-run:
	mvn -pl runtime-app-service -am spring-boot:run

functions-run:
	mvn -pl runtime-functions -am package azure-functions:run
