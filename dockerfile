##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/myapplication
WORKDIR /opt/myapplication
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/myapplication/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
