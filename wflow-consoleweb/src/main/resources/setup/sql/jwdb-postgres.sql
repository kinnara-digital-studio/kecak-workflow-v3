-- PostgreSQL Database Schema for Kecak Workflow / Joget
-- Generated for PostgreSQL 11+

DROP TABLE IF EXISTS SHKActivities CASCADE;
CREATE TABLE SHKActivities (
  Id varchar(100) NOT NULL,
  ActivitySetDefinitionId varchar(90) DEFAULT NULL,
  ActivityDefinitionId varchar(90) NOT NULL,
  Process numeric(19,0) NOT NULL,
  TheResource numeric(19,0) DEFAULT NULL,
  PDefName varchar(200) NOT NULL,
  ProcessId varchar(200) NOT NULL,
  ResourceId varchar(100) DEFAULT NULL,
  State numeric(19,0) NOT NULL,
  BlockActivityId varchar(100) DEFAULT NULL,
  Performer varchar(100) DEFAULT NULL,
  IsPerformerAsynchronous smallint DEFAULT NULL,
  Priority integer DEFAULT NULL,
  Name varchar(254) DEFAULT NULL,
  Activated bigint NOT NULL,
  ActivatedTZO bigint NOT NULL,
  Accepted bigint DEFAULT NULL,
  AcceptedTZO bigint DEFAULT NULL,
  LastStateTime bigint NOT NULL,
  LastStateTimeTZO bigint NOT NULL,
  LimitTime bigint NOT NULL,
  LimitTimeTZO bigint NOT NULL,
  Description varchar(254) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivities UNIQUE (Id)
);

DROP TABLE IF EXISTS SHKActivityData CASCADE;
CREATE TABLE SHKActivityData (
  Activity numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValue bytea DEFAULT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL double precision DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  IsResult smallint NOT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivityData UNIQUE (CNT),
  CONSTRAINT I2_SHKActivityData UNIQUE (Activity,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKActivityDataBLOBs CASCADE;
CREATE TABLE SHKActivityDataBLOBs (
  ActivityDataWOB numeric(19,0) NOT NULL,
  VariableValue bytea DEFAULT NULL,
  OrdNo integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivityDataBLOBs UNIQUE (ActivityDataWOB,OrdNo)
);

DROP TABLE IF EXISTS SHKActivityDataWOB CASCADE;
CREATE TABLE SHKActivityDataWOB (
  Activity numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL double precision DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  IsResult smallint NOT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivityDataWOB UNIQUE (CNT),
  CONSTRAINT I2_SHKActivityDataWOB UNIQUE (Activity,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKActivityStateEventAudits CASCADE;
CREATE TABLE SHKActivityStateEventAudits (
  KeyValue varchar(30) NOT NULL,
  Name varchar(50) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivityStateEventAudits UNIQUE (KeyValue),
  CONSTRAINT I2_SHKActivityStateEventAudits UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKActivityStates CASCADE;
CREATE TABLE SHKActivityStates (
  KeyValue varchar(30) NOT NULL,
  Name varchar(50) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKActivityStates UNIQUE (KeyValue),
  CONSTRAINT I2_SHKActivityStates UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKAndJoinTable CASCADE;
CREATE TABLE SHKAndJoinTable (
  Process numeric(19,0) NOT NULL,
  BlockActivity numeric(19,0) DEFAULT NULL,
  ActivityDefinitionId varchar(90) NOT NULL,
  Activity numeric(19,0) NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKAndJoinTable UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKAssignmentEventAudits CASCADE;
CREATE TABLE SHKAssignmentEventAudits (
  RecordedTime bigint NOT NULL,
  RecordedTimeTZO bigint NOT NULL,
  TheUsername varchar(100) NOT NULL,
  TheType numeric(19,0) NOT NULL,
  ActivityId varchar(100) NOT NULL,
  ActivityName varchar(254) DEFAULT NULL,
  ProcessId varchar(100) NOT NULL,
  ProcessName varchar(254) DEFAULT NULL,
  ProcessFactoryName varchar(200) NOT NULL,
  ProcessFactoryVersion varchar(20) NOT NULL,
  ActivityDefinitionId varchar(90) NOT NULL,
  ActivityDefinitionName varchar(90) DEFAULT NULL,
  ActivityDefinitionType integer NOT NULL,
  ProcessDefinitionId varchar(90) NOT NULL,
  ProcessDefinitionName varchar(90) DEFAULT NULL,
  PackageId varchar(90) NOT NULL,
  OldResourceUsername varchar(100) DEFAULT NULL,
  OldResourceName varchar(100) DEFAULT NULL,
  NewResourceUsername varchar(100) NOT NULL,
  NewResourceName varchar(100) DEFAULT NULL,
  IsAccepted smallint NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKAssignmentEventAudits UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKAssignmentsTable CASCADE;
CREATE TABLE SHKAssignmentsTable (
  Activity numeric(19,0) NOT NULL,
  TheResource numeric(19,0) NOT NULL,
  ActivityId varchar(100) NOT NULL,
  ActivityProcessId varchar(100) NOT NULL,
  ActivityProcessDefName varchar(200) NOT NULL,
  ResourceId varchar(100) NOT NULL,
  IsAccepted smallint NOT NULL,
  IsValid smallint NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKAssignmentsTable UNIQUE (CNT),
  CONSTRAINT I2_SHKAssignmentsTable UNIQUE (Activity,TheResource)
);

DROP TABLE IF EXISTS SHKCounters CASCADE;
CREATE TABLE SHKCounters (
  name varchar(100) NOT NULL,
  the_number numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKCounters UNIQUE (name)
);

DROP TABLE IF EXISTS SHKCreateProcessEventAudits CASCADE;
CREATE TABLE SHKCreateProcessEventAudits (
  RecordedTime bigint NOT NULL,
  RecordedTimeTZO bigint NOT NULL,
  TheUsername varchar(100) NOT NULL,
  TheType numeric(19,0) NOT NULL,
  ProcessId varchar(100) NOT NULL,
  ProcessName varchar(254) DEFAULT NULL,
  ProcessFactoryName varchar(200) NOT NULL,
  ProcessFactoryVersion varchar(20) NOT NULL,
  ProcessDefinitionId varchar(90) NOT NULL,
  ProcessDefinitionName varchar(90) DEFAULT NULL,
  PackageId varchar(90) NOT NULL,
  PActivityId varchar(100) DEFAULT NULL,
  PProcessId varchar(100) DEFAULT NULL,
  PProcessName varchar(254) DEFAULT NULL,
  PProcessFactoryName varchar(200) DEFAULT NULL,
  PProcessFactoryVersion varchar(20) DEFAULT NULL,
  PActivityDefinitionId varchar(90) DEFAULT NULL,
  PActivityDefinitionName varchar(90) DEFAULT NULL,
  PProcessDefinitionId varchar(90) DEFAULT NULL,
  PProcessDefinitionName varchar(90) DEFAULT NULL,
  PPackageId varchar(90) DEFAULT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKCreateProcessEventAudits UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKDataEventAudits CASCADE;
CREATE TABLE SHKDataEventAudits (
  RecordedTime bigint NOT NULL,
  RecordedTimeTZO bigint NOT NULL,
  TheUsername varchar(100) NOT NULL,
  TheType numeric(19,0) NOT NULL,
  ActivityId varchar(100) DEFAULT NULL,
  ActivityName varchar(254) DEFAULT NULL,
  ProcessId varchar(100) NOT NULL,
  ProcessName varchar(254) DEFAULT NULL,
  ProcessFactoryName varchar(200) NOT NULL,
  ProcessFactoryVersion varchar(20) NOT NULL,
  ActivityDefinitionId varchar(90) DEFAULT NULL,
  ActivityDefinitionName varchar(90) DEFAULT NULL,
  ActivityDefinitionType integer DEFAULT NULL,
  ProcessDefinitionId varchar(90) NOT NULL,
  ProcessDefinitionName varchar(90) DEFAULT NULL,
  PackageId varchar(90) NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKDataEventAudits UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKDeadlines CASCADE;
CREATE TABLE SHKDeadlines (
  Process numeric(19,0) NOT NULL,
  Activity numeric(19,0) NOT NULL,
  CNT numeric(19,0) NOT NULL,
  TimeLimit bigint NOT NULL,
  TimeLimitTZO bigint NOT NULL,
  ExceptionName varchar(100) NOT NULL,
  IsSynchronous smallint NOT NULL,
  IsExecuted smallint NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKDeadlines UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKEventTypes CASCADE;
CREATE TABLE SHKEventTypes (
  KeyValue varchar(30) NOT NULL,
  Name varchar(50) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKEventTypes UNIQUE (KeyValue),
  CONSTRAINT I2_SHKEventTypes UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKGroupGroupTable CASCADE;
CREATE TABLE SHKGroupGroupTable (
  sub_gid numeric(19,0) NOT NULL,
  groupid numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKGroupGroupTable UNIQUE (sub_gid,groupid)
);

DROP TABLE IF EXISTS SHKGroupTable CASCADE;
CREATE TABLE SHKGroupTable (
  groupid varchar(100) NOT NULL,
  description varchar(254) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKGroupTable UNIQUE (groupid)
);

DROP TABLE IF EXISTS SHKGroupUser CASCADE;
CREATE TABLE SHKGroupUser (
  USERNAME varchar(100) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKGroupUser UNIQUE (USERNAME)
);

DROP TABLE IF EXISTS SHKGroupUserPackLevelPart CASCADE;
CREATE TABLE SHKGroupUserPackLevelPart (
  PARTICIPANTOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKGroupUserPackLevelPart UNIQUE (PARTICIPANTOID,USEROID)
);

DROP TABLE IF EXISTS SHKGroupUserProcLevelPart CASCADE;
CREATE TABLE SHKGroupUserProcLevelPart (
  PARTICIPANTOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKGroupUserProcLevelPart UNIQUE (PARTICIPANTOID,USEROID)
);

DROP TABLE IF EXISTS SHKNewEventAuditData CASCADE;
CREATE TABLE SHKNewEventAuditData (
  DataEventAudit numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValue bytea DEFAULT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL float DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKNewEventAuditData UNIQUE (CNT),
  CONSTRAINT I2_SHKNewEventAuditData UNIQUE (DataEventAudit,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKNewEventAuditDataBLOBs CASCADE;
CREATE TABLE SHKNewEventAuditDataBLOBs (
  NewEventAuditDataWOB numeric(19,0) NOT NULL,
  VariableValue bytea DEFAULT NULL,
  OrdNo integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKNewEventAuditDataBLOBs UNIQUE (NewEventAuditDataWOB,OrdNo)
);

DROP TABLE IF EXISTS SHKNewEventAuditDataWOB CASCADE;
CREATE TABLE SHKNewEventAuditDataWOB (
  DataEventAudit numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL float DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKNewEventAuditDataWOB UNIQUE (CNT),
  CONSTRAINT I2_SHKNewEventAuditDataWOB UNIQUE (DataEventAudit,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKNextXPDLVersions CASCADE;
CREATE TABLE SHKNextXPDLVersions (
  XPDLId varchar(90) NOT NULL,
  NextVersion varchar(20) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKNextXPDLVersions UNIQUE (XPDLId,NextVersion)
);

DROP TABLE IF EXISTS SHKNormalUser CASCADE;
CREATE TABLE SHKNormalUser (
  USERNAME varchar(100) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKNormalUser UNIQUE (USERNAME)
);

DROP TABLE IF EXISTS SHKOldEventAuditData CASCADE;
CREATE TABLE SHKOldEventAuditData (
  DataEventAudit numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValue bytea DEFAULT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL float DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKOldEventAuditData UNIQUE (CNT),
  CONSTRAINT I2_SHKOldEventAuditData UNIQUE (DataEventAudit,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKOldEventAuditDataBLOBs CASCADE;
CREATE TABLE SHKOldEventAuditDataBLOBs (
  OldEventAuditDataWOB numeric(19,0) NOT NULL,
  VariableValue bytea DEFAULT NULL,
  OrdNo integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKOldEventAuditDataBLOBs UNIQUE (OldEventAuditDataWOB,OrdNo)
);

DROP TABLE IF EXISTS SHKOldEventAuditDataWOB CASCADE;
CREATE TABLE SHKOldEventAuditDataWOB (
  DataEventAudit numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL float DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKOldEventAuditDataWOB UNIQUE (CNT),
  CONSTRAINT I2_SHKOldEventAuditDataWOB UNIQUE (DataEventAudit,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKPackLevelParticipant CASCADE;
CREATE TABLE SHKPackLevelParticipant (
  PARTICIPANT_ID varchar(90) NOT NULL,
  PACKAGEOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelParticipant UNIQUE (PARTICIPANT_ID,PACKAGEOID)
);

DROP TABLE IF EXISTS SHKPackLevelXPDLApp CASCADE;
CREATE TABLE SHKPackLevelXPDLApp (
  APPLICATION_ID varchar(90) NOT NULL,
  PACKAGEOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelXPDLApp UNIQUE (APPLICATION_ID,PACKAGEOID)
);

DROP TABLE IF EXISTS SHKPackLevelXPDLAppTAAppDetUsr CASCADE;
CREATE TABLE SHKPackLevelXPDLAppTAAppDetUsr (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelXPDLAppTAAppDetUsr UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKPackLevelXPDLAppTAAppDetail CASCADE;
CREATE TABLE SHKPackLevelXPDLAppTAAppDetail (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelXPDLAppTAAppDetail UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKPackLevelXPDLAppTAAppUser CASCADE;
CREATE TABLE SHKPackLevelXPDLAppTAAppUser (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelXPDLAppTAAppUser UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKPackLevelXPDLAppToolAgntApp CASCADE;
CREATE TABLE SHKPackLevelXPDLAppToolAgntApp (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKPackLevelXPDLAppToolAgntApp UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKProcLevelParticipant CASCADE;
CREATE TABLE SHKProcLevelParticipant (
  PARTICIPANT_ID varchar(90) NOT NULL,
  PROCESSOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelParticipant UNIQUE (PARTICIPANT_ID,PROCESSOID)
);

DROP TABLE IF EXISTS SHKProcLevelXPDLApp CASCADE;
CREATE TABLE SHKProcLevelXPDLApp (
  APPLICATION_ID varchar(90) NOT NULL,
  PROCESSOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelXPDLApp UNIQUE (APPLICATION_ID,PROCESSOID)
);

DROP TABLE IF EXISTS SHKProcLevelXPDLAppTAAppDetUsr CASCADE;
CREATE TABLE SHKProcLevelXPDLAppTAAppDetUsr (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelXPDLAppTAAppDetUsr UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKProcLevelXPDLAppTAAppDetail CASCADE;
CREATE TABLE SHKProcLevelXPDLAppTAAppDetail (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelXPDLAppTAAppDetail UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKProcLevelXPDLAppTAAppUser CASCADE;
CREATE TABLE SHKProcLevelXPDLAppTAAppUser (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelXPDLAppTAAppUser UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKProcLevelXPDLAppToolAgntApp CASCADE;
CREATE TABLE SHKProcLevelXPDLAppToolAgntApp (
  XPDL_APPOID numeric(19,0) NOT NULL,
  TOOLAGENTOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcLevelXPDLAppToolAgntApp UNIQUE (XPDL_APPOID,TOOLAGENTOID)
);

DROP TABLE IF EXISTS SHKProcessData CASCADE;
CREATE TABLE SHKProcessData (
  Process numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValue bytea DEFAULT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL double precision DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessData UNIQUE (CNT),
  CONSTRAINT I2_SHKProcessData UNIQUE (Process,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKProcessDataBLOBs CASCADE;
CREATE TABLE SHKProcessDataBLOBs (
  ProcessDataWOB numeric(19,0) NOT NULL,
  VariableValue bytea DEFAULT NULL,
  OrdNo integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessDataBLOBs UNIQUE (ProcessDataWOB,OrdNo)
);

DROP TABLE IF EXISTS SHKProcessDataWOB CASCADE;
CREATE TABLE SHKProcessDataWOB (
  Process numeric(19,0) NOT NULL,
  VariableDefinitionId varchar(100) NOT NULL,
  VariableType integer NOT NULL,
  VariableValueXML text DEFAULT NULL,
  VariableValueVCHAR varchar(4000) DEFAULT NULL,
  VariableValueDBL double precision DEFAULT NULL,
  VariableValueLONG bigint DEFAULT NULL,
  VariableValueDATE timestamp DEFAULT NULL,
  VariableValueBOOL smallint DEFAULT NULL,
  OrdNo integer NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessDataWOB UNIQUE (CNT),
  CONSTRAINT I2_SHKProcessDataWOB UNIQUE (Process,VariableDefinitionId,OrdNo)
);

DROP TABLE IF EXISTS SHKProcessDefinitions CASCADE;
CREATE TABLE SHKProcessDefinitions (
  Name varchar(200) NOT NULL,
  PackageId varchar(90) NOT NULL,
  ProcessDefinitionId varchar(90) NOT NULL,
  ProcessDefinitionCreated bigint NOT NULL,
  ProcessDefinitionVersion varchar(20) NOT NULL,
  State integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessDefinitions UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKProcessRequesters CASCADE;
CREATE TABLE SHKProcessRequesters (
  Id varchar(100) NOT NULL,
  ActivityRequester numeric(19,0) DEFAULT NULL,
  ResourceRequester numeric(19,0) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessRequesters UNIQUE (Id)
);

DROP TABLE IF EXISTS SHKProcessStateEventAudits CASCADE;
CREATE TABLE SHKProcessStateEventAudits (
  KeyValue varchar(30) NOT NULL,
  Name varchar(50) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessStateEventAudits UNIQUE (KeyValue),
  CONSTRAINT I2_SHKProcessStateEventAudits UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKProcessStates CASCADE;
CREATE TABLE SHKProcessStates (
  KeyValue varchar(30) NOT NULL,
  Name varchar(50) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcessStates UNIQUE (KeyValue),
  CONSTRAINT I2_SHKProcessStates UNIQUE (Name)
);

DROP TABLE IF EXISTS SHKProcesses CASCADE;
CREATE TABLE SHKProcesses (
  SyncVersion bigint NOT NULL,
  Id varchar(100) NOT NULL,
  ProcessDefinition numeric(19,0) NOT NULL,
  PDefName varchar(200) NOT NULL,
  ActivityRequesterId varchar(100) DEFAULT NULL,
  ActivityRequesterProcessId varchar(100) DEFAULT NULL,
  ResourceRequesterId varchar(100) NOT NULL,
  ExternalRequesterClassName varchar(254) DEFAULT NULL,
  State numeric(19,0) NOT NULL,
  Priority integer DEFAULT NULL,
  Name varchar(254) DEFAULT NULL,
  Created bigint NOT NULL,
  CreatedTZO bigint NOT NULL,
  Started bigint DEFAULT NULL,
  StartedTZO bigint DEFAULT NULL,
  LastStateTime bigint NOT NULL,
  LastStateTimeTZO bigint NOT NULL,
  LimitTime bigint NOT NULL,
  LimitTimeTZO bigint NOT NULL,
  Description varchar(254) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKProcesses UNIQUE (Id)
);

DROP TABLE IF EXISTS SHKResourcesTable CASCADE;
CREATE TABLE SHKResourcesTable (
  Username varchar(100) NOT NULL,
  Name varchar(100) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKResourcesTable UNIQUE (Username)
);

DROP TABLE IF EXISTS SHKStateEventAudits CASCADE;
CREATE TABLE SHKStateEventAudits (
  RecordedTime bigint NOT NULL,
  RecordedTimeTZO bigint NOT NULL,
  TheUsername varchar(100) NOT NULL,
  TheType numeric(19,0) NOT NULL,
  ActivityId varchar(100) DEFAULT NULL,
  ActivityName varchar(254) DEFAULT NULL,
  ProcessId varchar(100) NOT NULL,
  ProcessName varchar(254) DEFAULT NULL,
  ProcessFactoryName varchar(200) NOT NULL,
  ProcessFactoryVersion varchar(20) NOT NULL,
  ActivityDefinitionId varchar(90) DEFAULT NULL,
  ActivityDefinitionName varchar(90) DEFAULT NULL,
  ActivityDefinitionType integer DEFAULT NULL,
  ProcessDefinitionId varchar(90) NOT NULL,
  ProcessDefinitionName varchar(90) DEFAULT NULL,
  PackageId varchar(90) NOT NULL,
  OldProcessState numeric(19,0) DEFAULT NULL,
  NewProcessState numeric(19,0) DEFAULT NULL,
  OldActivityState numeric(19,0) DEFAULT NULL,
  NewActivityState numeric(19,0) DEFAULT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKStateEventAudits UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKToolAgentApp CASCADE;
CREATE TABLE SHKToolAgentApp (
  TOOL_AGENT_NAME varchar(250) NOT NULL,
  APP_NAME varchar(90) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKToolAgentApp UNIQUE (TOOL_AGENT_NAME,APP_NAME)
);

DROP TABLE IF EXISTS SHKToolAgentAppDetail CASCADE;
CREATE TABLE SHKToolAgentAppDetail (
  APP_MODE numeric(10,0) NOT NULL,
  TOOLAGENT_APPOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKToolAgentAppDetail UNIQUE (APP_MODE,TOOLAGENT_APPOID)
);

DROP TABLE IF EXISTS SHKToolAgentAppDetailUser CASCADE;
CREATE TABLE SHKToolAgentAppDetailUser (
  TOOLAGENT_APPOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKToolAgentAppDetailUser UNIQUE (TOOLAGENT_APPOID,USEROID)
);

DROP TABLE IF EXISTS SHKToolAgentAppUser CASCADE;
CREATE TABLE SHKToolAgentAppUser (
  TOOLAGENT_APPOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKToolAgentAppUser UNIQUE (TOOLAGENT_APPOID,USEROID)
);

DROP TABLE IF EXISTS SHKToolAgentUser CASCADE;
CREATE TABLE SHKToolAgentUser (
  USERNAME varchar(100) NOT NULL,
  PWD varchar(100) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKToolAgentUser UNIQUE (USERNAME)
);

DROP TABLE IF EXISTS SHKUserGroupTable CASCADE;
CREATE TABLE SHKUserGroupTable (
  userid numeric(19,0) NOT NULL,
  groupid numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKUserGroupTable UNIQUE (userid,groupid)
);

DROP TABLE IF EXISTS SHKUserPackLevelPart CASCADE;
CREATE TABLE SHKUserPackLevelPart (
  PARTICIPANTOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKUserPackLevelPart UNIQUE (PARTICIPANTOID,USEROID)
);

DROP TABLE IF EXISTS SHKUserProcLevelParticipant CASCADE;
CREATE TABLE SHKUserProcLevelParticipant (
  PARTICIPANTOID numeric(19,0) NOT NULL,
  USEROID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKUserProcLevelParticipant UNIQUE (PARTICIPANTOID,USEROID)
);

DROP TABLE IF EXISTS SHKUserTable CASCADE;
CREATE TABLE SHKUserTable (
  userid varchar(100) NOT NULL,
  firstname varchar(50) DEFAULT NULL,
  lastname varchar(50) DEFAULT NULL,
  passwd varchar(50) NOT NULL,
  email varchar(254) DEFAULT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKUserTable UNIQUE (userid)
);

DROP TABLE IF EXISTS SHKXPDLApplicationPackage CASCADE;
CREATE TABLE SHKXPDLApplicationPackage (
  PACKAGE_ID varchar(90) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLApplicationPackage UNIQUE (PACKAGE_ID)
);

DROP TABLE IF EXISTS SHKXPDLApplicationProcess CASCADE;
CREATE TABLE SHKXPDLApplicationProcess (
  PROCESS_ID varchar(90) NOT NULL,
  PACKAGEOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLApplicationProcess UNIQUE (PROCESS_ID,PACKAGEOID)
);

DROP TABLE IF EXISTS SHKXPDLData CASCADE;
CREATE TABLE SHKXPDLData (
  XPDLContent bytea DEFAULT NULL,
  XPDLClassContent bytea DEFAULT NULL,
  XPDL numeric(19,0) NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLData UNIQUE (CNT),
  CONSTRAINT I2_SHKXPDLData UNIQUE (XPDL)
);

DROP TABLE IF EXISTS SHKXPDLHistory CASCADE;
CREATE TABLE SHKXPDLHistory (
  XPDLId varchar(90) NOT NULL,
  XPDLVersion varchar(20) NOT NULL,
  XPDLClassVersion bigint NOT NULL,
  XPDLUploadTime timestamp NOT NULL,
  XPDLHistoryUploadTime timestamp NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLHistory UNIQUE (XPDLId,XPDLVersion)
);

DROP TABLE IF EXISTS SHKXPDLHistoryData CASCADE;
CREATE TABLE SHKXPDLHistoryData (
  XPDLContent bytea NOT NULL,
  XPDLClassContent bytea NOT NULL,
  XPDLHistory numeric(19,0) NOT NULL,
  CNT numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLHistoryData UNIQUE (CNT)
);

DROP TABLE IF EXISTS SHKXPDLParticipantPackage CASCADE;
CREATE TABLE SHKXPDLParticipantPackage (
  PACKAGE_ID varchar(90) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLParticipantPackage UNIQUE (PACKAGE_ID)
);

DROP TABLE IF EXISTS SHKXPDLParticipantProcess CASCADE;
CREATE TABLE SHKXPDLParticipantProcess (
  PROCESS_ID varchar(90) NOT NULL,
  PACKAGEOID numeric(19,0) NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLParticipantProcess UNIQUE (PROCESS_ID,PACKAGEOID)
);

DROP TABLE IF EXISTS SHKXPDLReferences CASCADE;
CREATE TABLE SHKXPDLReferences (
  ReferredXPDLId varchar(90) NOT NULL,
  ReferringXPDL numeric(19,0) NOT NULL,
  ReferredXPDLNumber integer NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLReferences UNIQUE (ReferredXPDLId,ReferringXPDL)
);

DROP TABLE IF EXISTS SHKXPDLS CASCADE;
CREATE TABLE SHKXPDLS (
  XPDLId varchar(90) NOT NULL,
  XPDLVersion varchar(20) NOT NULL,
  XPDLClassVersion bigint NOT NULL,
  XPDLUploadTime timestamp NOT NULL,
  oid numeric(19,0) NOT NULL,
  version integer NOT NULL,
  PRIMARY KEY (oid),
  CONSTRAINT I1_SHKXPDLS UNIQUE (XPDLId,XPDLVersion)
);

DROP TABLE IF EXISTS app_app CASCADE;
CREATE TABLE app_app (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  name varchar(255) DEFAULT NULL,
  published boolean DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  license text DEFAULT NULL,
  description text DEFAULT NULL,
  meta text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion)
);

DROP TABLE IF EXISTS app_builder CASCADE;
CREATE TABLE app_builder (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  json text DEFAULT NULL,
  description text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS app_datalist CASCADE;
CREATE TABLE app_datalist (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description text DEFAULT NULL,
  json text DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS app_env_variable CASCADE;
CREATE TABLE app_env_variable (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  value text DEFAULT NULL,
  remarks text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS app_fd CASCADE;
CREATE TABLE app_fd (
  id varchar(255) NOT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS app_form CASCADE;
CREATE TABLE app_form (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  formId varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  tableName varchar(255) DEFAULT NULL,
  json text DEFAULT NULL,
  description text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,formId)
);

DROP TABLE IF EXISTS app_form_data_audit_trail CASCADE;
CREATE TABLE app_form_data_audit_trail (
  id varchar(255) NOT NULL,
  appId varchar(255) DEFAULT NULL,
  appVersion varchar(255) DEFAULT NULL,
  formId varchar(255) DEFAULT NULL,
  tableName varchar(255) DEFAULT NULL,
  username varchar(255) DEFAULT NULL,
  action varchar(255) DEFAULT NULL,
  data text DEFAULT NULL,
  datetime timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS app_message CASCADE;
CREATE TABLE app_message (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  ouid varchar(255) NOT NULL,
  messageKey varchar(255) DEFAULT NULL,
  locale varchar(255) DEFAULT NULL,
  message text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,ouid)
);

DROP TABLE IF EXISTS app_package CASCADE;
CREATE TABLE app_package (
  packageId varchar(255) NOT NULL,
  packageVersion bigint NOT NULL,
  name varchar(255) DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  appId varchar(255) DEFAULT NULL,
  appVersion bigint DEFAULT NULL,
  PRIMARY KEY (packageId,packageVersion)
);

DROP TABLE IF EXISTS app_package_activity_form CASCADE;
CREATE TABLE app_package_activity_form (
  processDefId varchar(255) NOT NULL,
  activityDefId varchar(255) NOT NULL,
  packageId varchar(255) NOT NULL,
  packageVersion bigint NOT NULL,
  ouid varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  formId varchar(255) DEFAULT NULL,
  formUrl varchar(255) DEFAULT NULL,
  formIFrameStyle varchar(255) DEFAULT NULL,
  autoContinue boolean DEFAULT NULL,
  disableSaveAsDraft boolean DEFAULT NULL,
  PRIMARY KEY (processDefId,activityDefId,packageId,packageVersion)
);

DROP TABLE IF EXISTS app_package_activity_plugin CASCADE;
CREATE TABLE app_package_activity_plugin (
  processDefId varchar(255) NOT NULL,
  activityDefId varchar(255) NOT NULL,
  packageId varchar(255) NOT NULL,
  packageVersion bigint NOT NULL,
  ouid varchar(255) DEFAULT NULL,
  pluginName varchar(255) DEFAULT NULL,
  pluginProperties text DEFAULT NULL,
  PRIMARY KEY (processDefId,activityDefId,packageId,packageVersion)
);

DROP TABLE IF EXISTS app_package_participant CASCADE;
CREATE TABLE app_package_participant (
  processDefId varchar(255) NOT NULL,
  participantId varchar(255) NOT NULL,
  packageId varchar(255) NOT NULL,
  packageVersion bigint NOT NULL,
  ouid varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  value text DEFAULT NULL,
  pluginProperties text DEFAULT NULL,
  PRIMARY KEY (processDefId,participantId,packageId,packageVersion)
);

DROP TABLE IF EXISTS app_plugin_default CASCADE;
CREATE TABLE app_plugin_default (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  pluginName varchar(255) DEFAULT NULL,
  pluginDescription text DEFAULT NULL,
  pluginProperties text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS app_report_activity CASCADE;
CREATE TABLE app_report_activity (
  uuid varchar(255) NOT NULL,
  activityDefId varchar(255) DEFAULT NULL,
  activityName varchar(255) DEFAULT NULL,
  processUid varchar(255) DEFAULT NULL,
  PRIMARY KEY (uuid)
);

DROP TABLE IF EXISTS app_report_activity_instance CASCADE;
CREATE TABLE app_report_activity_instance (
  instanceId varchar(255) NOT NULL,
  performer varchar(255) DEFAULT NULL,
  state varchar(255) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  nameOfAcceptedUser varchar(255) DEFAULT NULL,
  assignmentUsers text DEFAULT NULL,
  due timestamp DEFAULT NULL,
  createdTime timestamp DEFAULT NULL,
  startedTime timestamp DEFAULT NULL,
  finishTime timestamp DEFAULT NULL,
  delay bigint DEFAULT NULL,
  timeConsumingFromCreatedTime bigint DEFAULT NULL,
  timeConsumingFromStartedTime bigint DEFAULT NULL,
  activityUid varchar(255) DEFAULT NULL,
  processInstanceId varchar(255) DEFAULT NULL,
  PRIMARY KEY (instanceId)
);

DROP TABLE IF EXISTS app_report_app CASCADE;
CREATE TABLE app_report_app (
  uuid varchar(255) NOT NULL,
  appId varchar(255) DEFAULT NULL,
  appVersion varchar(255) DEFAULT NULL,
  appName varchar(255) DEFAULT NULL,
  PRIMARY KEY (uuid)
);

DROP TABLE IF EXISTS app_report_package CASCADE;
CREATE TABLE app_report_package (
  uuid varchar(255) NOT NULL,
  packageId varchar(255) DEFAULT NULL,
  packageName varchar(255) DEFAULT NULL,
  packageVersion varchar(255) DEFAULT NULL,
  appUid varchar(255) DEFAULT NULL,
  PRIMARY KEY (uuid)
);

DROP TABLE IF EXISTS app_report_process CASCADE;
CREATE TABLE app_report_process (
  uuid varchar(255) NOT NULL,
  processDefId varchar(255) DEFAULT NULL,
  processName varchar(255) DEFAULT NULL,
  packageUid varchar(255) DEFAULT NULL,
  PRIMARY KEY (uuid)
);

DROP TABLE IF EXISTS app_report_process_instance CASCADE;
CREATE TABLE app_report_process_instance (
  instanceId varchar(255) NOT NULL,
  requester varchar(255) DEFAULT NULL,
  state varchar(255) DEFAULT NULL,
  due timestamp DEFAULT NULL,
  startedTime timestamp DEFAULT NULL,
  finishTime timestamp DEFAULT NULL,
  delay bigint DEFAULT NULL,
  timeConsumingFromStartedTime bigint DEFAULT NULL,
  processUid varchar(255) DEFAULT NULL,
  PRIMARY KEY (instanceId)
);

DROP TABLE IF EXISTS app_resource CASCADE;
CREATE TABLE app_resource (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  filesize bigint DEFAULT NULL,
  permissionClass varchar(255) DEFAULT NULL,
  permissionProperties text DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS app_userview CASCADE;
CREATE TABLE app_userview (
  appId varchar(255) NOT NULL,
  appVersion bigint NOT NULL,
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description text DEFAULT NULL,
  json text DEFAULT NULL,
  dateCreated timestamp DEFAULT NULL,
  dateModified timestamp DEFAULT NULL,
  PRIMARY KEY (appId,appVersion,id)
);

DROP TABLE IF EXISTS dir_department CASCADE;
CREATE TABLE dir_department (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  organizationId varchar(255) DEFAULT NULL,
  hod varchar(255) DEFAULT NULL,
  parentId varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_employment CASCADE;
CREATE TABLE dir_employment (
  id varchar(255) NOT NULL,
  userId varchar(255) DEFAULT NULL,
  startDate date DEFAULT NULL,
  endDate date DEFAULT NULL,
  employeeCode varchar(255) DEFAULT NULL,
  role varchar(255) DEFAULT NULL,
  gradeId varchar(255) DEFAULT NULL,
  departmentId varchar(255) DEFAULT NULL,
  organizationId varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_employment_report_to CASCADE;
CREATE TABLE dir_employment_report_to (
  employmentId varchar(255) NOT NULL,
  reportToId varchar(255) NOT NULL,
  id varchar(255) DEFAULT NULL,
  PRIMARY KEY (employmentId,reportToId)
);

DROP TABLE IF EXISTS dir_grade CASCADE;
CREATE TABLE dir_grade (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  organizationId varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_group CASCADE;
CREATE TABLE dir_group (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  organizationId varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_organization CASCADE;
CREATE TABLE dir_organization (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  parentId varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_role CASCADE;
CREATE TABLE dir_role (
  id varchar(255) NOT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_user CASCADE;
CREATE TABLE dir_user (
  id varchar(255) NOT NULL,
  username varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  firstName varchar(255) DEFAULT NULL,
  lastName varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  active integer DEFAULT NULL,
  timeZone varchar(255) DEFAULT NULL,
  locale varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_user_extra CASCADE;
CREATE TABLE dir_user_extra (
  username varchar(255) NOT NULL,
  algorithm varchar(255) DEFAULT NULL,
  loginAttempt integer DEFAULT NULL,
  failedloginAttempt integer DEFAULT NULL,
  lastLogedInDate timestamp DEFAULT NULL,
  lockOutDate timestamp DEFAULT NULL,
  lastPasswordChangeDate timestamp DEFAULT NULL,
  requiredPasswordChange boolean DEFAULT NULL,
  noPasswordExpiration boolean DEFAULT NULL,
  PRIMARY KEY (username)
);

DROP TABLE IF EXISTS dir_user_group CASCADE;
CREATE TABLE dir_user_group (
  groupId varchar(255) NOT NULL,
  userId varchar(255) NOT NULL,
  PRIMARY KEY (userId,groupId)
);

DROP TABLE IF EXISTS dir_user_meta CASCADE;
CREATE TABLE dir_user_meta (
  username varchar(255) NOT NULL,
  meta_key varchar(255) NOT NULL,
  meta_value text DEFAULT NULL,
  PRIMARY KEY (username,meta_key)
);

DROP TABLE IF EXISTS dir_user_password_history CASCADE;
CREATE TABLE dir_user_password_history (
  id varchar(255) NOT NULL,
  username varchar(255) DEFAULT NULL,
  salt varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  updatedDate timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_user_replacement CASCADE;
CREATE TABLE dir_user_replacement (
  id varchar(255) NOT NULL,
  username varchar(255) DEFAULT NULL,
  replacementUser varchar(255) DEFAULT NULL,
  appId varchar(255) DEFAULT NULL,
  processIds varchar(255) DEFAULT NULL,
  startDate timestamp DEFAULT NULL,
  endDate timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS dir_user_role CASCADE;
CREATE TABLE dir_user_role (
  roleId varchar(255) NOT NULL,
  userId varchar(255) NOT NULL,
  PRIMARY KEY (userId,roleId)
);

DROP TABLE IF EXISTS objectid CASCADE;
CREATE TABLE objectid (
  nextoid numeric(19,0) NOT NULL,
  PRIMARY KEY (nextoid)
);

DROP TABLE IF EXISTS wf_audit_trail CASCADE;
CREATE TABLE wf_audit_trail (
  id varchar(255) NOT NULL,
  username varchar(255) DEFAULT NULL,
  clazz varchar(255) DEFAULT NULL,
  method varchar(255) DEFAULT NULL,
  message text DEFAULT NULL,
  timestamp timestamp DEFAULT NULL,
  appId varchar(255) DEFAULT NULL,
  appVersion varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS wf_process_link CASCADE;
CREATE TABLE wf_process_link (
  processId varchar(255) NOT NULL,
  parentProcessId varchar(255) DEFAULT NULL,
  originProcessId varchar(255) DEFAULT NULL,
  PRIMARY KEY (processId)
);

DROP TABLE IF EXISTS wf_report CASCADE;
CREATE TABLE wf_report (
  activityInstanceId varchar(255) NOT NULL,
  processInstanceId varchar(255) DEFAULT NULL,
  priority varchar(255) DEFAULT NULL,
  createdTime timestamp DEFAULT NULL,
  startedTime timestamp DEFAULT NULL,
  dateLimit bigint DEFAULT NULL,
  due timestamp DEFAULT NULL,
  delay bigint DEFAULT NULL,
  finishTime timestamp DEFAULT NULL,
  timeConsumingFromDateCreated bigint DEFAULT NULL,
  timeConsumingFromDateStarted bigint DEFAULT NULL,
  performer varchar(255) DEFAULT NULL,
  nameOfAcceptedUser varchar(255) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  state varchar(255) DEFAULT NULL,
  packageId varchar(255) DEFAULT NULL,
  processDefId varchar(255) DEFAULT NULL,
  activityDefId varchar(255) DEFAULT NULL,
  assignmentUsers text DEFAULT NULL,
  appId varchar(255) DEFAULT NULL,
  appVersion bigint DEFAULT NULL,
  PRIMARY KEY (activityInstanceId)
);

DROP TABLE IF EXISTS wf_report_activity CASCADE;
CREATE TABLE wf_report_activity (
  activityDefId varchar(255) NOT NULL,
  activityName varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  priority varchar(255) DEFAULT NULL,
  PRIMARY KEY (activityDefId)
);

DROP TABLE IF EXISTS wf_report_package CASCADE;
CREATE TABLE wf_report_package (
  packageId varchar(255) NOT NULL,
  packageName varchar(255) DEFAULT NULL,
  PRIMARY KEY (packageId)
);

DROP TABLE IF EXISTS wf_report_process CASCADE;
CREATE TABLE wf_report_process (
  processDefId varchar(255) NOT NULL,
  processName varchar(255) DEFAULT NULL,
  version varchar(255) DEFAULT NULL,
  PRIMARY KEY (processDefId)
);

DROP TABLE IF EXISTS wf_resource_bundle_message CASCADE;
CREATE TABLE wf_resource_bundle_message (
  id varchar(255) NOT NULL,
  messageKey varchar(255) DEFAULT NULL,
  locale varchar(255) DEFAULT NULL,
  message text DEFAULT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS wf_setup CASCADE;
CREATE TABLE wf_setup (
  id varchar(255) NOT NULL,
  property varchar(255) DEFAULT NULL,
  value text DEFAULT NULL,
  ordering integer DEFAULT NULL,
  PRIMARY KEY (id)
);

-- Indexes

CREATE INDEX idx_SHKActivities_SHKActivities_TheResource ON SHKActivities (TheResource);
CREATE INDEX idx_SHKActivities_SHKActivities_State ON SHKActivities (State);
CREATE INDEX idx_SHKActivities_I2_SHKActivities ON SHKActivities (Process,ActivitySetDefinitionId,ActivityDefinitionId);
CREATE INDEX idx_SHKActivities_I3_SHKActivities ON SHKActivities (Process,State);
CREATE INDEX idx_SHKAndJoinTable_SHKAndJoinTable_BlockActivity ON SHKAndJoinTable (BlockActivity);
CREATE INDEX idx_SHKAndJoinTable_I2_SHKAndJoinTable ON SHKAndJoinTable (Process,BlockActivity,ActivityDefinitionId);
CREATE INDEX idx_SHKAndJoinTable_I3_SHKAndJoinTable ON SHKAndJoinTable (Activity);
CREATE INDEX idx_SHKAssignmentEventAudits_SHKAssignmentEventAud_b13a3e20 ON SHKAssignmentEventAudits (TheType);
CREATE INDEX idx_SHKAssignmentsTable_I3_SHKAssignmentsTable ON SHKAssignmentsTable (TheResource,IsValid);
CREATE INDEX idx_SHKAssignmentsTable_I4_SHKAssignmentsTable ON SHKAssignmentsTable (ActivityId);
CREATE INDEX idx_SHKAssignmentsTable_I5_SHKAssignmentsTable ON SHKAssignmentsTable (ResourceId);
CREATE INDEX idx_SHKAssignmentsTable_FK_rnb6mhntls567xpifcfvygkuu ON SHKAssignmentsTable (ActivityProcessId);
CREATE INDEX idx_SHKCreateProcessEventAudits_SHKCreateProcessEv_5e69207c ON SHKCreateProcessEventAudits (TheType);
CREATE INDEX idx_SHKDataEventAudits_SHKDataEventAudits_TheType ON SHKDataEventAudits (TheType);
CREATE INDEX idx_SHKDeadlines_I2_SHKDeadlines ON SHKDeadlines (Process,TimeLimit);
CREATE INDEX idx_SHKDeadlines_I3_SHKDeadlines ON SHKDeadlines (Activity,TimeLimit);
CREATE INDEX idx_SHKGroupGroupTable_I2_SHKGroupGroupTable ON SHKGroupGroupTable (groupid);
CREATE INDEX idx_SHKGroupUserPackLevelPart_SHKGroupUserPackLeve_1832043b ON SHKGroupUserPackLevelPart (USEROID);
CREATE INDEX idx_SHKGroupUserProcLevelPart_SHKGroupUserProcLeve_497645c7 ON SHKGroupUserProcLevelPart (USEROID);
CREATE INDEX idx_SHKPackLevelParticipant_SHKPackLevelParticipan_e5b15b31 ON SHKPackLevelParticipant (PACKAGEOID);
CREATE INDEX idx_SHKPackLevelXPDLApp_SHKPackLevelXPDLApp_PACKAGEOID ON SHKPackLevelXPDLApp (PACKAGEOID);
CREATE INDEX idx_SHKPackLevelXPDLAppTAAppDetUsr_SHKPackLevelXPD_61198be8 ON SHKPackLevelXPDLAppTAAppDetUsr (TOOLAGENTOID);
CREATE INDEX idx_SHKPackLevelXPDLAppTAAppDetail_SHKPackLevelXPD_5440604b ON SHKPackLevelXPDLAppTAAppDetail (TOOLAGENTOID);
CREATE INDEX idx_SHKPackLevelXPDLAppTAAppUser_SHKPackLevelXPDLA_4e009429 ON SHKPackLevelXPDLAppTAAppUser (TOOLAGENTOID);
CREATE INDEX idx_SHKPackLevelXPDLAppToolAgntApp_SHKPackLevelXPD_7f8d275d ON SHKPackLevelXPDLAppToolAgntApp (TOOLAGENTOID);
CREATE INDEX idx_SHKProcLevelParticipant_SHKProcLevelParticipan_dbb6e45c ON SHKProcLevelParticipant (PROCESSOID);
CREATE INDEX idx_SHKProcLevelXPDLApp_SHKProcLevelXPDLApp_PROCESSOID ON SHKProcLevelXPDLApp (PROCESSOID);
CREATE INDEX idx_SHKProcLevelXPDLAppTAAppDetUsr_SHKProcLevelXPD_306f224b ON SHKProcLevelXPDLAppTAAppDetUsr (TOOLAGENTOID);
CREATE INDEX idx_SHKProcLevelXPDLAppTAAppDetail_SHKProcLevelXPD_1c5e34cb ON SHKProcLevelXPDLAppTAAppDetail (TOOLAGENTOID);
CREATE INDEX idx_SHKProcLevelXPDLAppTAAppUser_SHKProcLevelXPDLA_32ca640e ON SHKProcLevelXPDLAppTAAppUser (TOOLAGENTOID);
CREATE INDEX idx_SHKProcLevelXPDLAppToolAgntApp_SHKProcLevelXPD_e40ce434 ON SHKProcLevelXPDLAppToolAgntApp (TOOLAGENTOID);
CREATE INDEX idx_SHKProcessRequesters_I2_SHKProcessRequesters ON SHKProcessRequesters (ActivityRequester);
CREATE INDEX idx_SHKProcessRequesters_I3_SHKProcessRequesters ON SHKProcessRequesters (ResourceRequester);
CREATE INDEX idx_SHKProcesses_I2_SHKProcesses ON SHKProcesses (ProcessDefinition);
CREATE INDEX idx_SHKProcesses_I3_SHKProcesses ON SHKProcesses (State);
CREATE INDEX idx_SHKProcesses_I4_SHKProcesses ON SHKProcesses (ActivityRequesterId);
CREATE INDEX idx_SHKProcesses_I5_SHKProcesses ON SHKProcesses (ResourceRequesterId);
CREATE INDEX idx_SHKStateEventAudits_SHKStateEventAudits_TheType ON SHKStateEventAudits (TheType);
CREATE INDEX idx_SHKStateEventAudits_SHKStateEventAudits_OldProcessState ON SHKStateEventAudits (OldProcessState);
CREATE INDEX idx_SHKStateEventAudits_SHKStateEventAudits_NewProcessState ON SHKStateEventAudits (NewProcessState);
CREATE INDEX idx_SHKStateEventAudits_SHKStateEventAudits_OldActivityState ON SHKStateEventAudits (OldActivityState);
CREATE INDEX idx_SHKStateEventAudits_SHKStateEventAudits_NewActivityState ON SHKStateEventAudits (NewActivityState);
CREATE INDEX idx_SHKToolAgentAppDetail_SHKToolAgentAppDetail_TO_70c79a2d ON SHKToolAgentAppDetail (TOOLAGENT_APPOID);
CREATE INDEX idx_SHKToolAgentAppDetailUser_SHKToolAgentAppDetai_c3bb0adc ON SHKToolAgentAppDetailUser (USEROID);
CREATE INDEX idx_SHKToolAgentAppUser_SHKToolAgentAppUser_USEROID ON SHKToolAgentAppUser (USEROID);
CREATE INDEX idx_SHKUserGroupTable_SHKUserGroupTable_groupid ON SHKUserGroupTable (groupid);
CREATE INDEX idx_SHKUserPackLevelPart_SHKUserPackLevelPart_USEROID ON SHKUserPackLevelPart (USEROID);
CREATE INDEX idx_SHKUserProcLevelParticipant_SHKUserProcLevelPa_79fd0aa4 ON SHKUserProcLevelParticipant (USEROID);
CREATE INDEX idx_SHKXPDLApplicationProcess_SHKXPDLApplicationPr_714906ae ON SHKXPDLApplicationProcess (PACKAGEOID);
CREATE INDEX idx_SHKXPDLHistoryData_SHKXPDLHistoryData_XPDLHistory ON SHKXPDLHistoryData (XPDLHistory);
CREATE INDEX idx_SHKXPDLParticipantProcess_SHKXPDLParticipantPr_900d2faa ON SHKXPDLParticipantProcess (PACKAGEOID);
CREATE INDEX idx_SHKXPDLReferences_SHKXPDLReferences_ReferringXPDL ON SHKXPDLReferences (ReferringXPDL);
CREATE INDEX idx_app_app_idx_name ON app_app (name);
CREATE INDEX idx_app_builder_idx_name ON app_builder (name);
CREATE INDEX idx_app_builder_idx_type ON app_builder (type);
CREATE INDEX idx_app_datalist_FK5E9247A6462EF4C7 ON app_datalist (appId,appVersion);
CREATE INDEX idx_app_datalist_idx_name ON app_datalist (name);
CREATE INDEX idx_app_env_variable_FK740A62EC462EF4C7 ON app_env_variable (appId,appVersion);
CREATE INDEX idx_app_form_FK45957822462EF4C7 ON app_form (appId,appVersion);
CREATE INDEX idx_app_form_idx_name ON app_form (name);
CREATE INDEX idx_app_message_FKEE346FE9462EF4C7 ON app_message (appId,appVersion);
CREATE INDEX idx_app_package_FK852EA428462EF4C7 ON app_package (appId,appVersion);
CREATE INDEX idx_app_package_activity_form_FKA8D741D5F255BCC ON app_package_activity_form (packageId,packageVersion);
CREATE INDEX idx_app_package_activity_plugin_FKADE8644C5F255BCC ON app_package_activity_plugin (packageId,packageVersion);
CREATE INDEX idx_app_package_participant_FK6D7BF59C5F255BCC ON app_package_participant (packageId,packageVersion);
CREATE INDEX idx_app_plugin_default_FK7A835713462EF4C7 ON app_plugin_default (appId,appVersion);
CREATE INDEX idx_app_report_activity_FK5E33D79C918F93D ON app_report_activity (processUid);
CREATE INDEX idx_app_report_activity_instance_FK9C6ABDD8B06E2043 ON app_report_activity_instance (activityUid);
CREATE INDEX idx_app_report_activity_instance_FK9C6ABDD8D4610A90 ON app_report_activity_instance (processInstanceId);
CREATE INDEX idx_app_report_package_FKBD580A19E475ABC ON app_report_package (appUid);
CREATE INDEX idx_app_report_process_FKDAFFF442D40695DD ON app_report_process (packageUid);
CREATE INDEX idx_app_report_process_instance_FK351D7BF2918F93D ON app_report_process_instance (processUid);
CREATE INDEX idx_app_userview_FKE411D54E462EF4C7 ON app_userview (appId,appVersion);
CREATE INDEX idx_app_userview_idx_name ON app_userview (name);
CREATE INDEX idx_dir_department_FKEEE8AA4418CEBAE1 ON dir_department (organizationId);
CREATE INDEX idx_dir_department_FKEEE8AA44EF6BB2B7 ON dir_department (parentId);
CREATE INDEX idx_dir_department_FKEEE8AA4480DB1449 ON dir_department (hod);
CREATE INDEX idx_dir_employment_FKC6620ADE716AE35F ON dir_employment (departmentId);
CREATE INDEX idx_dir_employment_FKC6620ADE14CE02E9 ON dir_employment (gradeId);
CREATE INDEX idx_dir_employment_FKC6620ADECE539211 ON dir_employment (userId);
CREATE INDEX idx_dir_employment_FKC6620ADE18CEBAE1 ON dir_employment (organizationId);
CREATE INDEX idx_dir_employment_report_to_FK53622945F4068416 ON dir_employment_report_to (reportToId);
CREATE INDEX idx_dir_employment_report_to_FK536229452787E613 ON dir_employment_report_to (employmentId);
CREATE INDEX idx_dir_grade_FKBC9A49A518CEBAE1 ON dir_grade (organizationId);
CREATE INDEX idx_dir_group_FKBC9A804D18CEBAE1 ON dir_group (organizationId);
CREATE INDEX idx_dir_organization_FK55A15FA5961BD498 ON dir_organization (parentId);
CREATE INDEX idx_dir_user_group_FK2F0367FD159B6639 ON dir_user_group (groupId);
CREATE INDEX idx_dir_user_group_FK2F0367FDCE539211 ON dir_user_group (userId);
CREATE INDEX idx_dir_user_role_FK5C5FE738C8FE3CA7 ON dir_user_role (roleId);
CREATE INDEX idx_dir_user_role_FK5C5FE738CE539211 ON dir_user_role (userId);
CREATE INDEX idx_wf_report_FKB943CCA47A4E8F48 ON wf_report (packageId);
CREATE INDEX idx_wf_report_FKB943CCA4A39D6461 ON wf_report (processDefId);
CREATE INDEX idx_wf_report_FKB943CCA4CB863F ON wf_report (activityDefId);

-- Foreign Keys

ALTER TABLE SHKActivities ADD CONSTRAINT SHKActivities_Process FOREIGN KEY (Process) REFERENCES SHKProcesses (oid);
ALTER TABLE SHKActivities ADD CONSTRAINT SHKActivities_State FOREIGN KEY (State) REFERENCES SHKActivityStates (oid);
ALTER TABLE SHKActivities ADD CONSTRAINT SHKActivities_TheResource FOREIGN KEY (TheResource) REFERENCES SHKResourcesTable (oid);
ALTER TABLE SHKActivityData ADD CONSTRAINT SHKActivityData_Activity FOREIGN KEY (Activity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKActivityDataBLOBs ADD CONSTRAINT SHKActivityDataBLOBs_ActivityDataWOB FOREIGN KEY (ActivityDataWOB) REFERENCES SHKActivityDataWOB (oid);
ALTER TABLE SHKActivityDataWOB ADD CONSTRAINT SHKActivityDataWOB_Activity FOREIGN KEY (Activity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKAndJoinTable ADD CONSTRAINT SHKAndJoinTable_Activity FOREIGN KEY (Activity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKAndJoinTable ADD CONSTRAINT SHKAndJoinTable_BlockActivity FOREIGN KEY (BlockActivity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKAndJoinTable ADD CONSTRAINT SHKAndJoinTable_Process FOREIGN KEY (Process) REFERENCES SHKProcesses (oid);
ALTER TABLE SHKAssignmentEventAudits ADD CONSTRAINT SHKAssignmentEventAudits_TheType FOREIGN KEY (TheType) REFERENCES SHKEventTypes (oid);
ALTER TABLE SHKAssignmentsTable ADD CONSTRAINT FK_183e6adufsi558hl5p4dqkqsx FOREIGN KEY (ActivityId) REFERENCES SHKActivities (Id);
ALTER TABLE SHKAssignmentsTable ADD CONSTRAINT FK_rnb6mhntls567xpifcfvygkuu FOREIGN KEY (ActivityProcessId) REFERENCES SHKProcesses (Id);
ALTER TABLE SHKAssignmentsTable ADD CONSTRAINT SHKAssignmentsTable_Activity FOREIGN KEY (Activity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKAssignmentsTable ADD CONSTRAINT SHKAssignmentsTable_TheResource FOREIGN KEY (TheResource) REFERENCES SHKResourcesTable (oid);
ALTER TABLE SHKCreateProcessEventAudits ADD CONSTRAINT SHKCreateProcessEventAudits_TheType FOREIGN KEY (TheType) REFERENCES SHKEventTypes (oid);
ALTER TABLE SHKDataEventAudits ADD CONSTRAINT SHKDataEventAudits_TheType FOREIGN KEY (TheType) REFERENCES SHKEventTypes (oid);
ALTER TABLE SHKDeadlines ADD CONSTRAINT SHKDeadlines_Activity FOREIGN KEY (Activity) REFERENCES SHKActivities (oid);
ALTER TABLE SHKDeadlines ADD CONSTRAINT SHKDeadlines_Process FOREIGN KEY (Process) REFERENCES SHKProcesses (oid);
ALTER TABLE SHKGroupGroupTable ADD CONSTRAINT SHKGroupGroupTable_groupid FOREIGN KEY (groupid) REFERENCES SHKGroupTable (oid);
ALTER TABLE SHKGroupGroupTable ADD CONSTRAINT SHKGroupGroupTable_sub_gid FOREIGN KEY (sub_gid) REFERENCES SHKGroupTable (oid);
ALTER TABLE SHKGroupUserPackLevelPart ADD CONSTRAINT SHKGroupUserPackLevelPart_PARTICIPANTOID FOREIGN KEY (PARTICIPANTOID) REFERENCES SHKPackLevelParticipant (oid);
ALTER TABLE SHKGroupUserPackLevelPart ADD CONSTRAINT SHKGroupUserPackLevelPart_USEROID FOREIGN KEY (USEROID) REFERENCES SHKGroupUser (oid);
ALTER TABLE SHKGroupUserProcLevelPart ADD CONSTRAINT SHKGroupUserProcLevelPart_PARTICIPANTOID FOREIGN KEY (PARTICIPANTOID) REFERENCES SHKProcLevelParticipant (oid);
ALTER TABLE SHKGroupUserProcLevelPart ADD CONSTRAINT SHKGroupUserProcLevelPart_USEROID FOREIGN KEY (USEROID) REFERENCES SHKGroupUser (oid);
ALTER TABLE SHKNewEventAuditData ADD CONSTRAINT SHKNewEventAuditData_DataEventAudit FOREIGN KEY (DataEventAudit) REFERENCES SHKDataEventAudits (oid);
ALTER TABLE SHKNewEventAuditDataBLOBs ADD CONSTRAINT SHKNewEventAuditDataBLOBs_NewEventAuditDataWOB FOREIGN KEY (NewEventAuditDataWOB) REFERENCES SHKNewEventAuditDataWOB (oid);
ALTER TABLE SHKNewEventAuditDataWOB ADD CONSTRAINT SHKNewEventAuditDataWOB_DataEventAudit FOREIGN KEY (DataEventAudit) REFERENCES SHKDataEventAudits (oid);
ALTER TABLE SHKOldEventAuditData ADD CONSTRAINT SHKOldEventAuditData_DataEventAudit FOREIGN KEY (DataEventAudit) REFERENCES SHKDataEventAudits (oid);
ALTER TABLE SHKOldEventAuditDataBLOBs ADD CONSTRAINT SHKOldEventAuditDataBLOBs_OldEventAuditDataWOB FOREIGN KEY (OldEventAuditDataWOB) REFERENCES SHKOldEventAuditDataWOB (oid);
ALTER TABLE SHKOldEventAuditDataWOB ADD CONSTRAINT SHKOldEventAuditDataWOB_DataEventAudit FOREIGN KEY (DataEventAudit) REFERENCES SHKDataEventAudits (oid);
ALTER TABLE SHKPackLevelParticipant ADD CONSTRAINT SHKPackLevelParticipant_PACKAGEOID FOREIGN KEY (PACKAGEOID) REFERENCES SHKXPDLParticipantPackage (oid);
ALTER TABLE SHKPackLevelXPDLApp ADD CONSTRAINT SHKPackLevelXPDLApp_PACKAGEOID FOREIGN KEY (PACKAGEOID) REFERENCES SHKXPDLApplicationPackage (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppDetUsr ADD CONSTRAINT SHKPackLevelXPDLAppTAAppDetUsr_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppDetailUser (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppDetUsr ADD CONSTRAINT SHKPackLevelXPDLAppTAAppDetUsr_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKPackLevelXPDLApp (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppDetail ADD CONSTRAINT SHKPackLevelXPDLAppTAAppDetail_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppDetail (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppDetail ADD CONSTRAINT SHKPackLevelXPDLAppTAAppDetail_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKPackLevelXPDLApp (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppUser ADD CONSTRAINT SHKPackLevelXPDLAppTAAppUser_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppUser (oid);
ALTER TABLE SHKPackLevelXPDLAppTAAppUser ADD CONSTRAINT SHKPackLevelXPDLAppTAAppUser_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKPackLevelXPDLApp (oid);
ALTER TABLE SHKPackLevelXPDLAppToolAgntApp ADD CONSTRAINT SHKPackLevelXPDLAppToolAgntApp_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentApp (oid);
ALTER TABLE SHKPackLevelXPDLAppToolAgntApp ADD CONSTRAINT SHKPackLevelXPDLAppToolAgntApp_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKPackLevelXPDLApp (oid);
ALTER TABLE SHKProcLevelParticipant ADD CONSTRAINT SHKProcLevelParticipant_PROCESSOID FOREIGN KEY (PROCESSOID) REFERENCES SHKXPDLParticipantProcess (oid);
ALTER TABLE SHKProcLevelXPDLApp ADD CONSTRAINT SHKProcLevelXPDLApp_PROCESSOID FOREIGN KEY (PROCESSOID) REFERENCES SHKXPDLApplicationProcess (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppDetUsr ADD CONSTRAINT SHKProcLevelXPDLAppTAAppDetUsr_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppDetailUser (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppDetUsr ADD CONSTRAINT SHKProcLevelXPDLAppTAAppDetUsr_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKProcLevelXPDLApp (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppDetail ADD CONSTRAINT SHKProcLevelXPDLAppTAAppDetail_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppDetail (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppDetail ADD CONSTRAINT SHKProcLevelXPDLAppTAAppDetail_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKProcLevelXPDLApp (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppUser ADD CONSTRAINT SHKProcLevelXPDLAppTAAppUser_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentAppUser (oid);
ALTER TABLE SHKProcLevelXPDLAppTAAppUser ADD CONSTRAINT SHKProcLevelXPDLAppTAAppUser_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKProcLevelXPDLApp (oid);
ALTER TABLE SHKProcLevelXPDLAppToolAgntApp ADD CONSTRAINT SHKProcLevelXPDLAppToolAgntApp_TOOLAGENTOID FOREIGN KEY (TOOLAGENTOID) REFERENCES SHKToolAgentApp (oid);
ALTER TABLE SHKProcLevelXPDLAppToolAgntApp ADD CONSTRAINT SHKProcLevelXPDLAppToolAgntApp_XPDL_APPOID FOREIGN KEY (XPDL_APPOID) REFERENCES SHKProcLevelXPDLApp (oid);
ALTER TABLE SHKProcessData ADD CONSTRAINT SHKProcessData_Process FOREIGN KEY (Process) REFERENCES SHKProcesses (oid);
ALTER TABLE SHKProcessDataBLOBs ADD CONSTRAINT SHKProcessDataBLOBs_ProcessDataWOB FOREIGN KEY (ProcessDataWOB) REFERENCES SHKProcessDataWOB (oid);
ALTER TABLE SHKProcessDataWOB ADD CONSTRAINT SHKProcessDataWOB_Process FOREIGN KEY (Process) REFERENCES SHKProcesses (oid);
ALTER TABLE SHKProcessRequesters ADD CONSTRAINT SHKProcessRequesters_ActivityRequester FOREIGN KEY (ActivityRequester) REFERENCES SHKActivities (oid);
ALTER TABLE SHKProcessRequesters ADD CONSTRAINT SHKProcessRequesters_ResourceRequester FOREIGN KEY (ResourceRequester) REFERENCES SHKResourcesTable (oid);
ALTER TABLE SHKProcesses ADD CONSTRAINT SHKProcesses_ProcessDefinition FOREIGN KEY (ProcessDefinition) REFERENCES SHKProcessDefinitions (oid);
ALTER TABLE SHKProcesses ADD CONSTRAINT SHKProcesses_State FOREIGN KEY (State) REFERENCES SHKProcessStates (oid);
ALTER TABLE SHKStateEventAudits ADD CONSTRAINT SHKStateEventAudits_NewActivityState FOREIGN KEY (NewActivityState) REFERENCES SHKActivityStateEventAudits (oid);
ALTER TABLE SHKStateEventAudits ADD CONSTRAINT SHKStateEventAudits_NewProcessState FOREIGN KEY (NewProcessState) REFERENCES SHKProcessStateEventAudits (oid);
ALTER TABLE SHKStateEventAudits ADD CONSTRAINT SHKStateEventAudits_OldActivityState FOREIGN KEY (OldActivityState) REFERENCES SHKActivityStateEventAudits (oid);
ALTER TABLE SHKStateEventAudits ADD CONSTRAINT SHKStateEventAudits_OldProcessState FOREIGN KEY (OldProcessState) REFERENCES SHKProcessStateEventAudits (oid);
ALTER TABLE SHKStateEventAudits ADD CONSTRAINT SHKStateEventAudits_TheType FOREIGN KEY (TheType) REFERENCES SHKEventTypes (oid);
ALTER TABLE SHKToolAgentAppDetail ADD CONSTRAINT SHKToolAgentAppDetail_TOOLAGENT_APPOID FOREIGN KEY (TOOLAGENT_APPOID) REFERENCES SHKToolAgentApp (oid);
ALTER TABLE SHKToolAgentAppDetailUser ADD CONSTRAINT SHKToolAgentAppDetailUser_TOOLAGENT_APPOID FOREIGN KEY (TOOLAGENT_APPOID) REFERENCES SHKToolAgentAppDetail (oid);
ALTER TABLE SHKToolAgentAppDetailUser ADD CONSTRAINT SHKToolAgentAppDetailUser_USEROID FOREIGN KEY (USEROID) REFERENCES SHKToolAgentUser (oid);
ALTER TABLE SHKToolAgentAppUser ADD CONSTRAINT SHKToolAgentAppUser_TOOLAGENT_APPOID FOREIGN KEY (TOOLAGENT_APPOID) REFERENCES SHKToolAgentApp (oid);
ALTER TABLE SHKToolAgentAppUser ADD CONSTRAINT SHKToolAgentAppUser_USEROID FOREIGN KEY (USEROID) REFERENCES SHKToolAgentUser (oid);
ALTER TABLE SHKUserGroupTable ADD CONSTRAINT SHKUserGroupTable_groupid FOREIGN KEY (groupid) REFERENCES SHKGroupTable (oid);
ALTER TABLE SHKUserGroupTable ADD CONSTRAINT SHKUserGroupTable_userid FOREIGN KEY (userid) REFERENCES SHKUserTable (oid);
ALTER TABLE SHKUserPackLevelPart ADD CONSTRAINT SHKUserPackLevelPart_PARTICIPANTOID FOREIGN KEY (PARTICIPANTOID) REFERENCES SHKPackLevelParticipant (oid);
ALTER TABLE SHKUserPackLevelPart ADD CONSTRAINT SHKUserPackLevelPart_USEROID FOREIGN KEY (USEROID) REFERENCES SHKNormalUser (oid);
ALTER TABLE SHKUserProcLevelParticipant ADD CONSTRAINT SHKUserProcLevelParticipant_PARTICIPANTOID FOREIGN KEY (PARTICIPANTOID) REFERENCES SHKProcLevelParticipant (oid);
ALTER TABLE SHKUserProcLevelParticipant ADD CONSTRAINT SHKUserProcLevelParticipant_USEROID FOREIGN KEY (USEROID) REFERENCES SHKNormalUser (oid);
ALTER TABLE SHKXPDLApplicationProcess ADD CONSTRAINT SHKXPDLApplicationProcess_PACKAGEOID FOREIGN KEY (PACKAGEOID) REFERENCES SHKXPDLApplicationPackage (oid);
ALTER TABLE SHKXPDLData ADD CONSTRAINT SHKXPDLData_XPDL FOREIGN KEY (XPDL) REFERENCES SHKXPDLS (oid);
ALTER TABLE SHKXPDLHistoryData ADD CONSTRAINT SHKXPDLHistoryData_XPDLHistory FOREIGN KEY (XPDLHistory) REFERENCES SHKXPDLHistory (oid);
ALTER TABLE SHKXPDLParticipantProcess ADD CONSTRAINT SHKXPDLParticipantProcess_PACKAGEOID FOREIGN KEY (PACKAGEOID) REFERENCES SHKXPDLParticipantPackage (oid);
ALTER TABLE SHKXPDLReferences ADD CONSTRAINT SHKXPDLReferences_ReferringXPDL FOREIGN KEY (ReferringXPDL) REFERENCES SHKXPDLS (oid);
ALTER TABLE app_builder ADD CONSTRAINT FK_idup4nrrc79iy4kc46wf5919j FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_datalist ADD CONSTRAINT FK5E9247A6462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_env_variable ADD CONSTRAINT FK740A62EC462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_form ADD CONSTRAINT FK45957822462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_message ADD CONSTRAINT FKEE346FE9462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_package ADD CONSTRAINT FK852EA428462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_package_activity_form ADD CONSTRAINT FKA8D741D5F255BCC FOREIGN KEY (packageId, packageVersion) REFERENCES app_package (packageId, packageVersion);
ALTER TABLE app_package_activity_plugin ADD CONSTRAINT FKADE8644C5F255BCC FOREIGN KEY (packageId, packageVersion) REFERENCES app_package (packageId, packageVersion);
ALTER TABLE app_package_participant ADD CONSTRAINT FK6D7BF59C5F255BCC FOREIGN KEY (packageId, packageVersion) REFERENCES app_package (packageId, packageVersion);
ALTER TABLE app_plugin_default ADD CONSTRAINT FK7A835713462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_report_activity ADD CONSTRAINT FK5E33D79C918F93D FOREIGN KEY (processUid) REFERENCES app_report_process (uuid);
ALTER TABLE app_report_activity_instance ADD CONSTRAINT FK9C6ABDD8B06E2043 FOREIGN KEY (activityUid) REFERENCES app_report_activity (uuid);
ALTER TABLE app_report_activity_instance ADD CONSTRAINT FK9C6ABDD8D4610A90 FOREIGN KEY (processInstanceId) REFERENCES app_report_process_instance (instanceId);
ALTER TABLE app_report_package ADD CONSTRAINT FKBD580A19E475ABC FOREIGN KEY (appUid) REFERENCES app_report_app (uuid);
ALTER TABLE app_report_process ADD CONSTRAINT FKDAFFF442D40695DD FOREIGN KEY (packageUid) REFERENCES app_report_package (uuid);
ALTER TABLE app_report_process_instance ADD CONSTRAINT FK351D7BF2918F93D FOREIGN KEY (processUid) REFERENCES app_report_process (uuid);
ALTER TABLE app_resource ADD CONSTRAINT FK_nnvkg0h6yy8o3f4yjhd20ury0 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE app_userview ADD CONSTRAINT FKE411D54E462EF4C7 FOREIGN KEY (appId, appVersion) REFERENCES app_app (appId, appVersion);
ALTER TABLE dir_department ADD CONSTRAINT FKEEE8AA4418CEBAE1 FOREIGN KEY (organizationId) REFERENCES dir_organization (id);
ALTER TABLE dir_department ADD CONSTRAINT FKEEE8AA4480DB1449 FOREIGN KEY (hod) REFERENCES dir_employment (id);
ALTER TABLE dir_department ADD CONSTRAINT FKEEE8AA44EF6BB2B7 FOREIGN KEY (parentId) REFERENCES dir_department (id);
ALTER TABLE dir_employment ADD CONSTRAINT FKC6620ADE14CE02E9 FOREIGN KEY (gradeId) REFERENCES dir_grade (id);
ALTER TABLE dir_employment ADD CONSTRAINT FKC6620ADE18CEBAE1 FOREIGN KEY (organizationId) REFERENCES dir_organization (id);
ALTER TABLE dir_employment ADD CONSTRAINT FKC6620ADE716AE35F FOREIGN KEY (departmentId) REFERENCES dir_department (id);
ALTER TABLE dir_employment ADD CONSTRAINT FKC6620ADECE539211 FOREIGN KEY (userId) REFERENCES dir_user (id);
ALTER TABLE dir_employment_report_to ADD CONSTRAINT FK536229452787E613 FOREIGN KEY (employmentId) REFERENCES dir_employment (id);
ALTER TABLE dir_employment_report_to ADD CONSTRAINT FK53622945F4068416 FOREIGN KEY (reportToId) REFERENCES dir_employment (id);
ALTER TABLE dir_grade ADD CONSTRAINT FKBC9A49A518CEBAE1 FOREIGN KEY (organizationId) REFERENCES dir_organization (id);
ALTER TABLE dir_group ADD CONSTRAINT FKBC9A804D18CEBAE1 FOREIGN KEY (organizationId) REFERENCES dir_organization (id);
ALTER TABLE dir_organization ADD CONSTRAINT FK55A15FA5961BD498 FOREIGN KEY (parentId) REFERENCES dir_organization (id);
ALTER TABLE dir_user_group ADD CONSTRAINT FK2F0367FD159B6639 FOREIGN KEY (groupId) REFERENCES dir_group (id);
ALTER TABLE dir_user_group ADD CONSTRAINT FK2F0367FDCE539211 FOREIGN KEY (userId) REFERENCES dir_user (id);
ALTER TABLE dir_user_role ADD CONSTRAINT FK5C5FE738C8FE3CA7 FOREIGN KEY (roleId) REFERENCES dir_role (id);
ALTER TABLE dir_user_role ADD CONSTRAINT FK5C5FE738CE539211 FOREIGN KEY (userId) REFERENCES dir_user (id);
ALTER TABLE wf_report ADD CONSTRAINT FKB943CCA47A4E8F48 FOREIGN KEY (packageId) REFERENCES wf_report_package (packageId);
ALTER TABLE wf_report ADD CONSTRAINT FKB943CCA4A39D6461 FOREIGN KEY (processDefId) REFERENCES wf_report_process (processDefId);
ALTER TABLE wf_report ADD CONSTRAINT FKB943CCA4CB863F FOREIGN KEY (activityDefId) REFERENCES wf_report_activity (activityDefId);

-- Initial Data

INSERT INTO SHKActivityStates VALUES ('open.running','open.running',1000001,0),('open.not_running.not_started','open.not_running.not_started',1000003,0),('open.not_running.suspended','open.not_running.suspended',1000005,0),('closed.completed','closed.completed',1000007,0),('closed.terminated','closed.terminated',1000009,0),('closed.aborted','closed.aborted',1000011,0);
INSERT INTO SHKProcessStates VALUES ('open.running','open.running',1000000,0),('open.not_running.not_started','open.not_running.not_started',1000002,0),('open.not_running.suspended','open.not_running.suspended',1000004,0),('closed.completed','closed.completed',1000006,0),('closed.terminated','closed.terminated',1000008,0),('closed.aborted','closed.aborted',1000010,0);
INSERT INTO dir_role VALUES ('ROLE_ADMIN','Admin','Administrator'),('ROLE_USER','User','Normal User');
INSERT INTO dir_user VALUES ('admin','admin','21232f297a57a5a743894a0e4a801fc3','Admin','Admin',NULL,1,'0',NULL);
INSERT INTO dir_user_role VALUES ('ROLE_ADMIN','admin');
INSERT INTO objectid VALUES (1000200);
