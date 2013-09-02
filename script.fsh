if ( SHELL.promptBoolean("Create Project ?") ) {

  @projectName = SHELL.prompt("Project Name:");
  @packageName = SHELL.prompt("Package:");
  
  set ACCEPT_DEFAULTS true;

  new-project --named $projectName --topLevelPackage $packageName;
  beans setup;
  persistence setup --provider HIBERNATE --container JBOSS_EAP6;
  entity --named Kandidat;
  field string --named name;
  cd ..;
  
  java new-enum-type --named Partei --package ~.model;
  java new-enum-const CDU;
  java new-enum-const CSU;
  java new-enum-const Sonstige;
  cd ..;
  
  entity --named Stimme;
  field manyToOne --named erststimme --fieldType ~.model.Kandidat;
  field  custom --named zweitstimme --type ~.model.Partei;
  cd ~~;
  
  beans new-bean --type  ~.Wahl.java --scoped APPLICATION;
  java new-field "@javax.persistence.PersistenceContext private javax.persistence.EntityManager em;";
  @stimmeClass = packageName.concat(".model.Stimme");
  java new-method "public void waehle(" $stimmeClass " s) {em.persist(s); }";
  
  set ACCEPT_DEFAULTS false;
}

