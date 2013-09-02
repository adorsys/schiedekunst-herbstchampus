arquillian setup --containerType MANAGED --containerName JBOSS_AS_MANAGED_7.X 
arquillian configure-container --profile arq-jboss_as_managed_7.x 
arquillian create-test --class hc.ewahl.Wahl.java --enableJPA