FROM cptactionhank/atlassian-jira-software:7.3.3

ADD ./atlassian-extras-3.2.jar ${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib/atlassian-extras-3.2.jar 
ADD ./jira-core-language-pack-zh_CN-7.2.1.jar   ${JIRA_INSTALL}/atlassian-jira/WEB-INF/atlassian-bundled-plugins/jira-core-language-pack-zh_CN-7.2.1.jar
COPY ./mysql-connector-java-5.1.39-bin.jar  ${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib/

USER root:root
RUN  chown -R daemon:daemon ${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib/atlassian-extras-3.2.jar \
   &&  chown -R daemon:daemon ${JIRA_INSTALL}/atlassian-jira/WEB-INF/atlassian-bundled-plugins/jira-core-language-pack-zh_CN-7.2.1.jar \
   && chown -R daemon:daemon  ${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib/mysql-connector-java-5.1.39-bin.jar
WORKDIR /var/atlassian/jira

EXPOSE 8080

 

# Run Atlassian JIRA as a foreground process by default.
ENTRYPOINT  /opt/atlassian/jira/bin/start-jira.sh -fg && while true; do sleep 30;done

 