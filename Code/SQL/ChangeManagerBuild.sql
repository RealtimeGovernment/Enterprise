create table Application (
   i_Application        bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Application_Stereotype default 0,
   Name                 varchar(30)          not null,
   ApplicationType      varchar(15)          not null constraint DF_Application_ApplicationType default 'Default',
   Roadmap              bigint               not null constraint DF_Application_Roadmap default 0,
   Profile              bigint               not null constraint DF_Application_Profile default 0,
   BusinessUnit         bigint               not null constraint DF_Application_BusinessUnit default 0,
   Purpose              nvarchar(Max)        null,
   MissionLevel         varchar(15)          not null constraint DF_Application_MissionLevel default 'Default',
   DownThreshold        varchar(15)          not null constraint DF_Application_DownThreshold default 'Default',
   RecoveryLevel        varchar(15)          not null constraint DF_Application_RecoveryLevel default 'Default',
   Business_ProductManager bigint               not null constraint DF_Application_BusinessProductManager default 0,
   Business_OperationsManager bigint               not null constraint DF_Application_BusinessOperationsManager default 0,
   Business_ApplicationManager bigint               not null constraint DF_Application_BusinessApplicationManager default 0,
   Tech_CustomerAgent   bigint               not null constraint DF_Application_TechCustomerAgent default 0,
   Tech_OperationsManager bigint               not null constraint DF_Application_TechOperationsManager default 0,
   Tech_ApplicationManager bigint               not null constraint DF_Application_TechApplicationManager default 0,
   Tech_ProductManager  bigint               not null constraint DF_Application_TechProductManager default 0,
   GeneralStatus        varchar(15)          not null constraint DF_Application_GeneralStatus default 'Normal'
)
go

alter table Application
   add constraint i_Application primary key (i_Application)
go

alter table Application
   add constraint n_ApplicationName unique (Stereotype, Name)
go

create table ApplicationComponent (
   i_Component          bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_ApplicationComponent_Stereotype default 0,
   Application          bigint               not null constraint DF_ApplicationComponent_Application default 0,
   Name                 varchar(30)          not null,
   Roadmap              bigint               not null constraint DF_ApplicationComponent_Roadmap default 0,
   Profile              bigint               not null constraint DF_ApplicationComponent_Profile default 0,
   Environment_Current  bigint               not null constraint DF_ApplicationComponent_EnvironmentCurrent default 0,
   Environment_Target   bigint               not null constraint DF_ApplicationComponent_EnvironmentTarget default 0,
   Technology_Client    bigint               null constraint DF_ApplicationComponent_TechnologyClient default 0,
   Technology_ApplicationServer bigint               null constraint DF_ApplicationComponent_TechnologyApplicationServer default 0,
   Technology_ORM       bigint               null constraint DF_ApplicationComponent_TechnologyORM default 0,
   Technology_DatabasePlatform bigint               null constraint DF_ApplicationComponent_TechnologyDatabasePlatform default 0,
   Technology_PlatformStack bigint               null constraint DF_ApplicationComponent_TechnologyPlatformStack default 0,
   Technology_DevelopmentLanguage bigint               null constraint DF_ApplicationComponent_TechnologyDevelopmentLanguage default 0,
   Deploy_Development   bigint               null constraint DF_ApplicationComponent_DeployDevelopment default 0,
   Deploy_Test          bigint               null constraint DF_ApplicationComponent_DeployTest default 0,
   Deploy_Staging       bigint               null constraint DF_ApplicationComponent_DeployStaging default 0,
   Deploy_Production    bigint               null constraint DF_ApplicationComponent_DeployProduction default 0,
   Deploy_Recovery      bigint               null constraint DF_ApplicationComponent_DeployRecovery default 0,
   h_Node               AS (([t_Node].[ToString]())),
   h_Parent             AS (([t_Node].[GetAncestor]((1)).ToString())),
   h_Value_Bigint       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   h_Value_String       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   t_Tree               bigint               not null constraint DF_ApplicationComponent_tTree default 0,
   t_Node               hierarchyid          null constraint DF_ApplicationComponent_tNode default '/',
   GeneralStatus        varchar(15)          not null constraint DF_ApplicationComponent_GeneralStatus default 'Normal'
)
go

alter table ApplicationComponent
   add constraint i_ApplicationComponent primary key (i_Component)
go

alter table ApplicationComponent
   add constraint n_ApplicationComponent unique (Name, Stereotype)
go

create table ApplicationType (
   ApplicationType      varchar(15)          not null constraint DF_ApplicationType_ApplicationType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ApplicationType
   add constraint CKC_ApplicationType_DisplayOrder check (DisplayOrder >= 1)
go

alter table ApplicationType
   add constraint n_ListValue primary key (ApplicationType)
go

create unique index Index_1 on ApplicationType (
DisplayOrder ASC
)
go

create table ApplicationUserGroup (
   i_ApplicationUserGroup bigint               identity,
   Stereotype           bigint               not null constraint DF_ApplicationUserGroup_Stereotype default 0,
   Application          bigint               not null constraint DF_ApplicationUserGroup_Application default 0,
   Organization         bigint               not null constraint DF_ApplicationUserGroup_Organization default 0,
   Name                 varchar(30)          not null,
   Distribution         varchar(15)          not null constraint DF_ApplicationUserGroup_Distribution default 'Default',
   Quantity             int                  not null constraint DF_ApplicationUserGroup_Quantity default 0,
   GeneralStatus        varchar(15)          not null constraint DF_ApplicationUserGroup_GeneralStatus default 'Normal'
)
go

alter table ApplicationUserGroup
   add constraint CKC_ApplicationUserGroup_Quantity check (Quantity >= 0)
go

alter table ApplicationUserGroup
   add constraint i_ApplicationUserGroup primary key nonclustered (i_ApplicationUserGroup)
go

alter table ApplicationUserGroup
   add constraint n_ApplicationUserGroup unique (Application, Organization, Stereotype, Distribution)
go

create table ArchitectureType (
   ArchitectureType     varchar(15)          not null constraint DF_ArchitectureType_ArchitectureType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ArchitectureType
   add constraint CKC_ArchitectureType_DisplayOrder check (DisplayOrder >= 1)
go

alter table ArchitectureType
   add constraint n_ArchitectureType primary key (ArchitectureType)
go

create unique index Index_1 on ArchitectureType (
DisplayOrder ASC
)
go

create table BusinessProfileStatus (
   BusinessProfileStatus varchar(15)          not null constraint DF_BusinessProfileStatus_BusinessProfileStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table BusinessProfileStatus
   add constraint CKC_BusinessProfileStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table BusinessProfileStatus
   add constraint n_BusinessProfileStatus primary key (BusinessProfileStatus)
go

create unique index Index_1 on BusinessProfileStatus (
DisplayOrder ASC
)
go

create table BusinessService (
   i_BusinessService    bigint               identity,
   Stereotype           bigint               not null constraint DF_BusinessService_Stereotype default 0,
   Name                 varchar(30)          not null,
   BusinessUnit         bigint               not null constraint DF_BusinessService_BusinessUnit default 0,
   BusinessServiceType  varchar(15)          not null constraint DF_BusinessService_BusinessServiceType default 'Default',
   Roadmap              bigint               not null constraint DF_BusinessService_Roadmap default 0,
   Description          nvarchar(Max)        null,
   Summary              varchar(510)         null,
   Comment              nvarchar(Max)        null,
   GeneralStatus        varchar(15)          not null constraint DF_BusinessService_GeneralStatus default 'Normal'
)
go

alter table BusinessService
   add constraint i_BusinessService primary key (i_BusinessService)
go

alter table BusinessService
   add constraint n_BusinessService unique (Stereotype, Name)
go

create table BusinessServiceApplication (
   i_BusinessServiceApplication bigint               identity,
   Stereotype           bigint               not null constraint DF_BusinessServiceApplication_Stereotype default 0,
   BusinessService      bigint               not null constraint DF_BusinessServiceApplication_BusinessService default 0,
   Application          bigint               not null constraint DF_BusinessServiceApplication_Application default 0,
   MissionLevel         varchar(15)          not null constraint DF_BusinessServiceApplication_MissionLevel default 'Default',
   Description          nvarchar(Max)        null,
   Summary              varchar(510)         null,
   DisplayOrder         int                  not null,
   Comment              nvarchar(Max)        null,
   HowUsed              nvarchar(Max)        null,
   GeneralStatus        varchar(15)          not null constraint DF_BusinessServiceApplication_GeneralStatus default 'Normal'
)
go

alter table BusinessServiceApplication
   add constraint CKC_BusinessServiceApplication_DisplayOrder check (DisplayOrder >= 1)
go

alter table BusinessServiceApplication
   add constraint [i BusinessServiceApplication] primary key (i_BusinessServiceApplication)
go

alter table BusinessServiceApplication
   add constraint n_BusinessServiceApplication unique (Stereotype, BusinessService, Application)
go

create table BusinessServiceType (
   BusinessServiceType  varchar(15)          not null constraint DF_BusinessServiceType_BusinessServiceType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table BusinessServiceType
   add constraint CKC_BusinessServiceType_DisplayOrder check (DisplayOrder >= 1)
go

alter table BusinessServiceType
   add constraint [n BusinessServiceType] primary key (BusinessServiceType)
go

create unique index Index_1 on BusinessServiceType (
DisplayOrder ASC
)
go

create table BusinessUnit (
   i_BusinessUnit       bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_BusinessUnit_Stereotype default 0,
   Organization         bigint               not null constraint DF_BusinessUnit_Organization default 0,
   Name                 varchar(30)          not null,
   BusinessUnitType     varchar(15)          not null constraint DF_BusinessUnit_BusinessUnitType default 'Default',
   Roadmap              bigint               not null constraint DF_BusinessUnit_Roadmap default 0,
   BusinessLeader       bigint               not null constraint DF_BusinessUnit_BusinessLeader default 0,
   TechnologyLeader     bigint               not null constraint DF_BusinessUnit_TechnologyLeader default 0,
   OperationsLeader     bigint               not null constraint DF_BusinessUnit_OperationsLeader default 0,
   ApplicationProfilePerson bigint               not null constraint DF_BusinessUnit_ApplicationProfilePerson default 0,
   ServerProfilePerson  bigint               not null constraint DF_BusinessUnit_ServerProfilePerson default 0,
   ApplicationProfileStatus varchar(15)          not null constraint DF_BusinessUnit_ApplicationProfileStatus default 'Default',
   ServiceProfileStatus varchar(15)          not null constraint DF_BusinessUnit_ServiceProfileStatus default 'Default',
   ServerProfileStatus  varchar(15)          not null constraint DF_BusinessUnit_ServerProfileStatus default 'Default',
   ServicesProfilePerson bigint               not null constraint DF_BusinessUnit_ServicesProfilePerson default 0,
   ApplicationsProfileDate date                 null,
   ServersProfileDate   date                 null,
   ServiceProfileDate   date                 null,
   GeneralStatus        varchar(15)          not null constraint DF_BusinessUnit_GeneralStatus default 'Normal'
)
go

alter table BusinessUnit
   add constraint i_BusinessUnit primary key (i_BusinessUnit)
go

alter table BusinessUnit
   add constraint n_BusinessUnitName unique (Name, Stereotype)
go

create table BusinessUnitType (
   BusinessUnitType     varchar(15)          not null constraint DF_BusinessUnitType_BusinessUnitType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table BusinessUnitType
   add constraint CKC_BusinessUnitType_DisplayOrder check (DisplayOrder >= 1)
go

alter table BusinessUnitType
   add constraint n_BusinessUnitType primary key (BusinessUnitType)
go

create unique index Index_1 on BusinessUnitType (
DisplayOrder ASC
)
go

create table ChangeCost (
   I_ChangeCost         bigint               identity,
   Profile              bigint               not null constraint DF_ChangeCost_Profile default 0,
   Stereotype           bigint               not null constraint DF_ChangeCost_Stereotype default 0,
   ChangeCostCategory   varchar(15)          not null constraint DF_ChangeCost_ChangeCostCategory default 'Default',
   ChangeCostStatus     varchar(15)          not null constraint DF_ChangeCost_ChangeCostStatus default 'Default',
   Cost                 decimal(14,2)        not null constraint DF_ChangeCost_Cost default 0,
   Description          nvarchar(Max)        null,
   Comment              nvarchar(Max)        null,
   DisplayOrder         int                  not null,
   GeneralStatus        varchar(15)          not null constraint DF_ChangeCost_GeneralStatus default 'Normal'
)
go

alter table ChangeCost
   add constraint CKC_ChangeCost_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeCost
   add constraint i_ChangeCost primary key (I_ChangeCost)
go

alter table ChangeCost
   add constraint n_ChangeCost unique (Profile, Stereotype)
go

create table ChangeCostCategory (
   ChangeCostCategory   varchar(15)          not null constraint DF_ChangeCostCategory_ChangeCostCategory default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null,
   isDirect             bit                  not null constraint DF_ChangeCostCategory_isDirect default 0,
   isIndirect           bit                  not null constraint DF_ChangeCostCategory_isIndirect default 0,
   isExtended           bit                  not null constraint DF_ChangeCostCategory_isExtended default 0,
   isCapital            bit                  not null constraint DF_ChangeCostCategory_isCapital default 0
)
go

alter table ChangeCostCategory
   add constraint CKC_ChangeCostCategory_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeCostCategory
   add constraint n_ChangeCostCategory primary key (ChangeCostCategory)
go

create unique index Index_1 on ChangeCostCategory (
DisplayOrder ASC
)
go

create table ChangeCostStatus (
   ChangeCostStatus     varchar(15)          not null constraint DF_ChangeCostStatus_ChangeCostStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ChangeCostStatus
   add constraint CKC_ChangeCostStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeCostStatus
   add constraint [n ChangeCostStatus] primary key (ChangeCostStatus)
go

create unique index Index_1 on ChangeCostStatus (
DisplayOrder ASC
)
go

create table ChangeStatus (
   ChangeStatus         varchar(15)          not null constraint DF_ChangeStatus_ChangeStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ChangeStatus
   add constraint CKC_ChangeStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeStatus
   add constraint n_ChangeStatus primary key (ChangeStatus)
go

create unique index Index_1 on ChangeStatus (
DisplayOrder ASC
)
go

create table ChangeTicket (
   i_ChangeTicket       bigint               identity,
   Profile              bigint               not null constraint DF_ChangeTicket_Profile default 0,
   TicketID             varchar(30)          null,
   Name                 varchar(30)          not null,
   Summary              varchar(510)         null,
   Description          nvarchar(Max)        null,
   TicketOwner          bigint               not null constraint DF_ChangeTicket_TicketOwner default 0,
   ChangeTicketSystem   varchar(15)          not null constraint DF_ChangeTicket_ChangeTicketSystem default 'Default',
   ChangeTicketStatus   varchar(15)          not null constraint DF_ChangeTicket_ChangeTicketStatus default 'Default',
   SubmitDate           date                 not null,
   GeneralStatus        varchar(15)          not null constraint DF_ChangeTicket_GeneralStatus default 'Normal'
)
go

alter table ChangeTicket
   add constraint i_ChangeTicket primary key (i_ChangeTicket)
go

create table ChangeTicketStatus (
   ChangeTicketStatus   varchar(15)          not null constraint DF_ChangeTicketStatus_ChangeTicketStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ChangeTicketStatus
   add constraint CKC_ChangeTicketStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeTicketStatus
   add constraint n_ChangeTicketStatus primary key (ChangeTicketStatus)
go

create unique index Index_1 on ChangeTicketStatus (
DisplayOrder ASC
)
go

create table ChangeTicketSystem (
   ChangeTicketSystem   varchar(15)          not null constraint DF_ChangeTicketSystem_ChangeTicketSystem default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ChangeTicketSystem
   add constraint CKC_ChangeTicketSystem_DisplayOrder check (DisplayOrder >= 1)
go

alter table ChangeTicketSystem
   add constraint i_ChangeTicketSystem primary key (ChangeTicketSystem)
go

create table Cpu (
   CPU                  varchar(15)          not null constraint DF_Cpu_CPU default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table Cpu
   add constraint CKC_Cpu_DisplayOrder check (DisplayOrder >= 1)
go

alter table Cpu
   add constraint n_CPU primary key (CPU)
go

create unique index Index_1 on Cpu (
DisplayOrder ASC
)
go

create table DevelopmentStage (
   DevelopmentStage     varchar(15)          not null constraint DF_DevelopmentStage_DevelopmentStage default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table DevelopmentStage
   add constraint CKC_DevelopmentStage_DisplayOrder check (DisplayOrder >= 1)
go

alter table DevelopmentStage
   add constraint n_DevelopmentStage primary key (DevelopmentStage)
go

create unique index Index_1 on DevelopmentStage (
DisplayOrder ASC
)
go

create table DevelopmentType (
   DevelopmentType      varchar(15)          not null constraint DF_DevelopmentType_DevelopmentType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table DevelopmentType
   add constraint CKC_DevelopmentType_DisplayOrder check (DisplayOrder >= 1)
go

alter table DevelopmentType
   add constraint n_DevelopmentType primary key (DevelopmentType)
go

create unique index Index_1 on DevelopmentType (
DisplayOrder ASC
)
go

create table [Disk] (
   [Disk]               varchar(15)          not null constraint DF_Disk_Disk default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table [Disk]
   add constraint CKC_Disk_DisplayOrder check (DisplayOrder >= 1)
go

alter table [Disk]
   add constraint n_Disk primary key ([Disk])
go

create unique index Index_1 on [Disk] (
DisplayOrder ASC
)
go

create table Distribution (
   Distribution         varchar(15)          not null constraint DF_Distribution_Distribution default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table Distribution
   add constraint CKC_Distribution_DisplayOrder check (DisplayOrder >= 1)
go

alter table Distribution
   add constraint n_Distribution primary key (Distribution)
go

create unique index Index_1 on Distribution (
DisplayOrder ASC
)
go

create table DownThreshold (
   DownThreshold        varchar(15)          not null constraint DF_DownThreshold_DownThreshold default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table DownThreshold
   add constraint CKC_DownThreshold_DisplayOrder check (DisplayOrder >= 1)
go

alter table DownThreshold
   add constraint n_DownThreshold primary key (DownThreshold)
go

create unique index Index_1 on DownThreshold (
DisplayOrder ASC
)
go

create table Edition (
   Edition              varchar(15)          not null constraint DF_Edition_Edition default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table Edition
   add constraint CKC_Edition_DisplayOrder check (DisplayOrder >= 1)
go

alter table Edition
   add constraint n_Edition primary key (Edition)
go

create unique index Index_1 on Edition (
DisplayOrder ASC
)
go

create table EmploymentType (
   EmploymentType       varchar(15)          not null constraint DF_EmploymentType_EmploymentType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table EmploymentType
   add constraint CKC_EmploymentType_DisplayOrder check (DisplayOrder >= 1)
go

alter table EmploymentType
   add constraint n_EmploymentType primary key (EmploymentType)
go

create unique index Index_1 on EmploymentType (
DisplayOrder ASC
)
go

create table Environment (
   i_Environment        bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Environment_Stereotype default 0,
   Name                 varchar(30)          not null,
   Edition              varchar(15)          not null constraint DF_Environment_Edition default 'Default',
   Version              varchar(15)          not null constraint DF_Environment_Version default 'Default',
   Roadmap              bigint               not null constraint DF_Environment_Roadmap default 0,
   GeneralStatus        varchar(15)          not null constraint DF_Environment_GeneralStatus default 'Normal'
)
go

alter table Environment
   add constraint i_Environement primary key (i_Environment)
go

alter table Environment
   add constraint n_Environment unique (Name, Edition, Version, Stereotype)
go

create table EnvironmentTechnology (
   i_EnvironmentTechnology bigint               identity,
   Stereotype           bigint               not null constraint DF_EnvironmentTechnology_Stereotype default 0,
   Environment          bigint               not null constraint DF_EnvironmentTechnology_Environment default 0,
   Technology           bigint               not null constraint DF_EnvironmentTechnology_Technology default 0,
   Name                 varchar(30)          not null constraint DF_EnvironmentTechnology_Name default 'Unnamed',
   PrimaryUse           nvarchar(Max)        null,
   Restrictions         nvarchar(Max)        null,
   GeneralStatus        varchar(15)          not null constraint DF_EnvironmentTechnology_GeneralStatus default 'Normal'
)
go

alter table EnvironmentTechnology
   add constraint i_EnvironmentTechnology primary key (i_EnvironmentTechnology)
go

alter table EnvironmentTechnology
   add constraint n_EnvironmentTechnology unique (Environment, Technology, Stereotype)
go

create table ExecutionStage (
   ExecutionStage       varchar(15)          not null constraint DF_ExecutionStage_ExecutionStage default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ExecutionStage
   add constraint CKC_ExecutionStage_DisplayOrder check (DisplayOrder >= 1)
go

alter table ExecutionStage
   add constraint n_ExecutionStage primary key (ExecutionStage)
go

create unique index Index_1 on ExecutionStage (
DisplayOrder ASC
)
go

create table ExecutionState (
   ExecutionState       varchar(15)          not null constraint DF_ExecutionState_ExecutionState default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ExecutionState
   add constraint CKC_ExecutionState_DisplayOrder check (DisplayOrder >= 1)
go

alter table ExecutionState
   add constraint n_ExecutionState primary key (ExecutionState)
go

create unique index Index_1 on ExecutionState (
ExecutionState ASC
)
go

create table ExecutionStatus (
   ExecutionStatus      varchar(15)          not null constraint DF_ExecutionStatus_ExecutionStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ExecutionStatus
   add constraint CKC_ExecutionStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table ExecutionStatus
   add constraint n_ExecutionStatus primary key (ExecutionStatus)
go

create unique index Index_1 on ExecutionStatus (
DisplayOrder ASC
)
go

create table FormFactor (
   FormFactor           varchar(15)          not null constraint DF_FormFactor_FormFactor default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table FormFactor
   add constraint CKC_FormFactor_DisplayOrder check (DisplayOrder >= 1)
go

alter table FormFactor
   add constraint n_FormFactor primary key (FormFactor)
go

create unique index Index_1 on FormFactor (
DisplayOrder ASC
)
go

create table GeneralStatus (
   GeneralStatus        varchar(15)          not null constraint DF_GeneralStatus_GeneralStatus default 'Normal',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table GeneralStatus
   add constraint CKC_GeneralStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table GeneralStatus
   add constraint n_GeneralStatus primary key (GeneralStatus)
go

create unique index Index_1 on GeneralStatus (
DisplayOrder ASC
)
go

create table JobTitle (
   JobTitle             varchar(15)          not null constraint DF_JobTitle_JobTitle default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table JobTitle
   add constraint CKC_JobTitle_DisplayOrder check (DisplayOrder >= 1)
go

alter table JobTitle
   add constraint n_JobTitle primary key (JobTitle)
go

create unique index Index_1 on JobTitle (
DisplayOrder ASC
)
go

create table LicenseType (
   LicenseType          varchar(15)          not null constraint DF_LicenseType_LicenseType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table LicenseType
   add constraint CKC_LicenseType_DisplayOrder check (DisplayOrder >= 1)
go

alter table LicenseType
   add constraint n_LicenseType primary key (LicenseType)
go

create unique index Index_1 on LicenseType (
DisplayOrder ASC
)
go

create table LifecycleStage (
   LifecycleStage       varchar(15)          not null constraint DF_LifecycleStage_LifecycleStage default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table LifecycleStage
   add constraint CKC_LifecycleStage_DisplayOrder check (DisplayOrder >= 1)
go

alter table LifecycleStage
   add constraint n_LifecycleStage primary key (LifecycleStage)
go

create unique index Index_1 on LifecycleStage (
DisplayOrder ASC
)
go

create table LifecycleState (
   LifecycleState       varchar(15)          not null constraint DF_LifecycleState_LifecycleState default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table LifecycleState
   add constraint CKC_LifecycleState_DisplayOrder check (DisplayOrder >= 1)
go

alter table LifecycleState
   add constraint n_LifecycleState primary key (LifecycleState)
go

create unique index Index_1 on LifecycleState (
DisplayOrder ASC
)
go

create table Location (
   i_Location           bigint               identity,
   Stereotype           bigint               not null constraint DF_Location_Stereotype default 0,
   Name                 varchar(30)          not null,
   Description          nvarchar(Max)        null,
   h_Node               AS (([t_Node].[ToString]())),
   h_Parent             AS (([t_Node].[GetAncestor]((1)).ToString())),
   h_Value_Bigint       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   h_Value_String       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   t_Tree               bigint               not null constraint DF_Location_tTree default 0,
   t_Node               hierarchyid          not null constraint DF_Location_tNode default '/',
   GeneralStatus        varchar(15)          not null constraint DF_Location_GeneralStatus default 'Normal'
)
go

alter table Location
   add constraint i_Location primary key (i_Location)
go

alter table Location
   add constraint n_Location unique (Name, Stereotype)
go

create table MissionLevel (
   MissionLevel         varchar(15)          not null constraint DF_MissionLevel_MissionLevel default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table MissionLevel
   add constraint CKC_MissionLevel_DisplayOrder check (DisplayOrder >= 1)
go

alter table MissionLevel
   add constraint n_MissionLevel primary key (MissionLevel)
go

create unique index Index_1 on MissionLevel (
DisplayOrder ASC
)
go

create table OperatingCost (
   i_OperatingCost      bigint               identity,
   Stereotype           bigint               not null constraint DF_OperatingCost_Stereotype default 0,
   Profile              bigint               not null constraint DF_OperatingCost_Profile default 0,
   OperatingCostCategory varchar(15)          not null constraint DF_OperatingCost_OperatingCostCategory default 'Default',
   OperatingCostStatus  varchar(15)          not null constraint DF_OperatingCost_OperatingCostStatus default 'Default',
   Cost                 decimal(14,2)        not null constraint DF_OperatingCost_Cost default 0,
   Description          nvarchar(Max)        null,
   Comment              nvarchar(Max)        null,
   DisplayOrder         int                  not null,
   GeneralStatus        varchar(15)          not null constraint DF_OperatingCost_GeneralStatus default 'Normal',
   is_Current           bit                  not null constraint DF_OperatingCost_isCurrent default 0,
   is_Target            bit                  not null constraint DF_OperatingCost_isTarget default 0
)
go

alter table OperatingCost
   add constraint CKC_OperatingCost_DisplayOrder check (DisplayOrder >= 1)
go

alter table OperatingCost
   add constraint i_OperatingCost primary key (i_OperatingCost)
go

alter table OperatingCost
   add constraint n_OperatingCost unique (Stereotype, Profile)
go

create table OperatingCostCategory (
   OperatingCostCategory varchar(15)          not null constraint DF_OperatingCostCategory_OperatingCostCategory default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null,
   isDirect             bit                  not null constraint DF_OperatingCostCategory_isDirect default 0,
   isIndirect           bit                  not null constraint DF_OperatingCostCategory_isIndirect default 0,
   isExtended           bit                  not null constraint DF_OperatingCostCategory_isExtended default 0,
   isCapital            bit                  not null constraint DF_OperatingCostCategory_isCapital default 0
)
go

alter table OperatingCostCategory
   add constraint CKC_OperatingCostCategory_DisplayOrder check (DisplayOrder >= 1)
go

alter table OperatingCostCategory
   add constraint n_OperatingCostCategory primary key (OperatingCostCategory)
go

create unique index Index_1 on OperatingCostCategory (
DisplayOrder ASC
)
go

create table OperatingCostStatus (
   OperatingCostStatus  varchar(15)          not null constraint DF_OperatingCostStatus_OperatingCostStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table OperatingCostStatus
   add constraint CKC_OperatingCostStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table OperatingCostStatus
   add constraint n_OperatingCostStatus primary key (OperatingCostStatus)
go

create unique index Index_1 on OperatingCostStatus (
DisplayOrder ASC
)
go

create table OperatingSystem (
   OperatingSystem      varchar(15)          not null constraint DF_OperatingSystem_OperatingSystem default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table OperatingSystem
   add constraint CKC_OperatingSystem_DisplayOrder check (DisplayOrder >= 1)
go

alter table OperatingSystem
   add constraint n_OperatingSystem primary key (OperatingSystem)
go

create unique index Index_1 on OperatingSystem (
DisplayOrder ASC
)
go

create table Organization (
   i_Organization       bigint               identity(1, 1),
   Classification       varchar(30)          not null constraint DF_Organization_Classification default 'Default',
   Name                 varchar(30)          not null,
   Roadmap              bigint               not null constraint DF_Organization_Roadmap default 0,
   Description          nvarchar(Max)        null,
   Summary              varchar(510)         null,
   Comment              nvarchar(Max)        null,
   OrganizationType     varchar(15)          not null constraint DF_Organization_OrganizationType default 'Default',
   OrganizationLeader   bigint               not null constraint DF_Organization_OrganizationLeader default 0,
   TechnologyLeader     bigint               not null constraint DF_Organization_TechnologyLeader default 0,
   Applications_Date    date                 null,
   Servers_Date         date                 null,
   h_Node               AS (([t_Node].[ToString]())),
   h_Parent             AS (([t_Node].[GetAncestor]((1)).ToString())),
   h_Value_Bigint       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   h_Value_String       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   t_Tree               bigint               not null constraint DF_Organization_tTree default 0,
   t_Node               hierarchyid          not null constraint DF_Organization_tNode default '/',
   GeneralStatus        varchar(15)          not null constraint DF_Organization_GeneralStatus default 'Normal'
)
go

alter table Organization
   add constraint i_Organization primary key (i_Organization)
go

alter table Organization
   add constraint h_Organization unique (t_Tree, t_Node)
go

create table OrganizationClassification (
   OrganizationClassification varchar(30)          not null constraint DF_OrganizationClassification_OrganizationClassification default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table OrganizationClassification
   add constraint CKC_OrganizationClassification_DisplayOrder check (DisplayOrder >= 1)
go

alter table OrganizationClassification
   add constraint n_OrganizationClassification primary key (OrganizationClassification)
go

create unique index Index_1 on OrganizationClassification (
DisplayOrder ASC
)
go

create table OrganizationType (
   OrganizationType     varchar(15)          not null constraint DF_OrganizationType_OrganizationType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table OrganizationType
   add constraint CKC_OrganizationType_DisplayOrder check (DisplayOrder >= 1)
go

alter table OrganizationType
   add constraint n_OrganizationType primary key (OrganizationType)
go

create unique index Index_1 on OrganizationType (
DisplayOrder ASC
)
go

create table PackageType (
   PackageType          varchar(15)          not null constraint DF_PackageType_PackageType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table PackageType
   add constraint CKC_PackageType_DisplayOrder check (DisplayOrder >= 1)
go

alter table PackageType
   add constraint n_PackageType primary key (PackageType)
go

create unique index Index_1 on PackageType (
DisplayOrder ASC
)
go

create table Person (
   i_Person             bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Person_Stereotype default 0,
   Organization         bigint               not null constraint DF_Person_Organization default 0,
   Name_First           varchar(30)          not null,
   Name_Last            varchar(30)          not null,
   Email                varchar(60)          not null,
   FullName             AS (Name_First + ', ' + Name_Last),
   JobTitle             varchar(15)          not null constraint DF_Person_JobTitle default 'Default',
   Phone_Office         varchar(15)          null constraint DF_Person_PhoneOffice default '01 512 999-0000',
   isActive             bit                  not null constraint DF_Person_isActive default 0,
   JobNumber            varchar(15)          null constraint DF_Person_JobNumber default 'NA',
   EmploymentType       varchar(15)          not null constraint DF_Person_EmploymentType default 'Default',
   YearsEmployed        int                  not null constraint DF_Person_YearsEmployed default 0,
   Description          nvarchar(Max)        null,
   Email_2              varchar(60)          null,
   Phone_Mobile         varchar(15)          null constraint DF_Person_PhoneMobile default '01 512 555-0000',
   Location_Street_1    varchar(30)          null,
   Location_Street_2    varchar(30)          null,
   MailCode             varchar(8)           null,
   Location_City        varchar(30)          not null constraint DF_Person_LocationCity default 'Austin',
   State                char(2)              not null constraint DF_Person_State default 'TX',
   PartTime             bit                  not null constraint DF_Person_PartTime default 0,
   Start_Date_Original  date                 not null constraint DF_Person_StartDateOriginal default '1-1-1900',
   Start_Date_Contract  date                 not null,
   End_Contract         date                 not null,
   End_Final            date                 not null,
   Track_Comment        nvarchar(Max)        null,
   GeneralStatus        varchar(15)          not null constraint DF_Person_GeneralStatus default 'Normal'
)
go

alter table Person
   add constraint CKC_Person_YearsEmployed check (YearsEmployed >= 0)
go

alter table Person
   add constraint i_Person primary key (i_Person)
go

alter table Person
   add constraint n_Person unique (Stereotype, Organization, Name_First, Name_Last)
go

alter table Person
   add constraint n_Email unique (Email)
go

create table Product (
   i_Product            bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Product_Stereotype default 0,
   Name                 varchar(30)          not null,
   Profile              bigint               not null constraint DF_Product_Profile default 0,
   Roadmap              bigint               not null constraint DF_Product_Roadmap default 0,
   Producer             bigint               not null constraint DF_Product_Producer default 0,
   PackageType          varchar(15)          not null constraint DF_Product_PackageType default 'Default',
   DevelopmentStage     varchar(15)          not null constraint DF_Product_DevelopmentStage default 'Default',
   LicenseType          varchar(15)          not null constraint DF_Product_LicenseType default 'Default',
   DevelopmentType      varchar(15)          not null constraint DF_Product_DevelopmentType default 'Default',
   ProjectName          varchar(30)          not null,
   GeneralStatus        varchar(15)          not null constraint DF_Product_GeneralStatus default 'Normal'
)
go

alter table Product
   add constraint i_Product primary key (i_Product)
go

alter table Product
   add constraint n_Product unique (Stereotype, Name)
go

create table Profile (
   i_Profile            bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Profile_Stereotype default 0,
   Technology           bigint               not null constraint DF_Profile_Technology default 0,
   Name_Code            varchar(8)           null,
   Name_Short           varchar(15)          not null,
   Name_Common          varchar(30)          not null,
   Name_Full            varchar(60)          not null,
   Info_Summary         varchar(510)         null,
   Info_Description     nvarchar(Max)        null,
   Info_Comment         nvarchar(Max)        null,
   Owner_Business       bigint               not null constraint DF_Profile_OwnerBusiness default 0,
   Owner_Technology     bigint               not null constraint DF_Profile_OwnerTechnology default 0,
   Owner_Funding        bigint               not null constraint DF_Profile_OwnerFunding default 0,
   Contact_Technology   bigint               not null constraint DF_Profile_ContactTechnology default 0,
   Contact_Business     bigint               not null constraint DF_Profile_ContactBusiness default 0,
   Support_Application  bigint               not null constraint DF_Profile_SupportApplication default 0,
   Support_Platform     bigint               not null constraint DF_Profile_SupportPlatform default 0,
   Support_Status       varchar(15)          not null constraint DF_Profile_SupportStatus default 'Default',
   Support_Type         varchar(15)          not null constraint DF_Profile_SupportType default 'Default',
   ServiceLevel_Availability varchar(15)          not null constraint DF_Profile_ServiceLevelAvailability default 'Default',
   ServiceLevel_Support varchar(15)          not null constraint DF_Profile_ServiceLevelSupport default 'Default',
   ServiceLevel_Restore varchar(15)          not null constraint DF_Profile_ServiceLevelRestore default 'Default',
   ServiceLevel_Recovery varchar(15)          not null constraint DF_Profile_ServiceLevelRecovery default 'Default',
   Spec_Technology      bigint               not null constraint DF_Profile_SpecTechnology default 0,
   Spec_Cpu             varchar(15)          not null constraint DF_Profile_SpecCpu default 'Default',
   Spec_Disk            varchar(15)          not null constraint DF_Profile_SpecDisk default 'Default',
   Spec_Ram             varchar(15)          not null constraint DF_Profile_SpecRam default 'Default',
   Spec_OperatingSystem varchar(15)          not null constraint DF_Profile_SpecOperatingSystem default 'Default',
   Spec_FormFactor      varchar(15)          not null constraint DF_Profile_SpecFormFactor default 'Default',
   Current_Status       varchar(15)          not null constraint DF_Profile_CurrentStatus default 'Default',
   Change_Manager       bigint               null constraint DF_Profile_ChangeManager default 0,
   Change_Funding_Required decimal(14,2)        not null constraint DF_Profile_ChangeFundingRequired default 0,
   Change_Funding_Secured decimal(14,2)        not null constraint DF_Profile_ChangeFundingSecured default 0,
   Change_Funding_Spent decimal(14,2)        not null constraint DF_Profile_ChangeFundingSpent default 0,
   Change_Plan          bigint               null,
   Change_Stage         varchar(15)          not null constraint DF_Profile_ChangeStage default 'Entry',
   Change_State         varchar(15)          not null constraint DF_Profile_ChangeState default 'Entry',
   Change_Status        varchar(15)          not null constraint DF_Profile_ChangeStatus default 'Normal',
   Change_Timing_Start  date                 null,
   Change_Timing_End    date                 null,
   Change_Tickets       varchar(510)         null,
   Profile_Baseline_Date date                 null,
   Profile_Baseline_Person bigint               not null constraint DF_Profile_ProfileBaselinePerson default 0,
   Profile_Baseline_Signoff bigint               not null constraint DF_Profile_ProfileBaselineSignoff default 0,
   Profile_Plan         varchar(62)          null,
   Profile_Stage        varchar(15)          not null constraint DF_Profile_ProfileStage default 'Entry',
   Profile_State        varchar(15)          not null constraint DF_Profile_ProfileState default 'Entry',
   Profile_Status       varchar(15)          not null constraint DF_Profile_ProfileStatus default 'Default',
   Profile_Manager      bigint               not null constraint DF_Profile_ProfileManager default 0,
   Profile_IsCurrent    bit                  not null constraint DF_Profile_ProfileIsCurrent default 0,
   Profile_IsTarget     bit                  not null constraint DF_Profile_ProfileIsTarget default 0,
   d_Create_Date        date                 null constraint DF_Profile_dCreateDate default GetDate(),
   d_Create_Person      bigint               null constraint DF_Profile_dCreatePerson default 0,
   d_Update_Date        date                 null,
   d_Update_Person      bigint               null constraint DF_Profile_dUpdatePerson default 0,
   GeneralStatus        varchar(15)          not null constraint DF_Profile_GeneralStatus default 'Normal'
)
go

alter table Profile
   add constraint i_Profile primary key nonclustered (i_Profile)
go

create index s_Technology on Profile (
Technology ASC
)
go

create table Ram (
   Ram                  varchar(15)          not null constraint DF_Ram_Ram default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table Ram
   add constraint CKC_Ram_DisplayOrder check (DisplayOrder >= 1)
go

alter table Ram
   add constraint n_Ram primary key (Ram)
go

create unique index Index_1 on Ram (
DisplayOrder ASC
)
go

create table RecoveryLevel (
   RecoveryLevel        varchar(15)          not null constraint DF_RecoveryLevel_RecoveryLevel default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table RecoveryLevel
   add constraint CKC_RecoveryLevel_DisplayOrder check (DisplayOrder >= 1)
go

alter table RecoveryLevel
   add constraint n_RecoveryLevel primary key (RecoveryLevel)
go

create unique index Index_1 on RecoveryLevel (
DisplayOrder ASC
)
go

create table RetireApproach (
   RetireApproach       varchar(15)          not null constraint DF_RetireApproach_RetireApproach default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table RetireApproach
   add constraint CKC_RetireApproach_DisplayOrder check (DisplayOrder >= 1)
go

alter table RetireApproach
   add constraint n_RetireApproach primary key (RetireApproach)
go

create unique index Index_1 on RetireApproach (
DisplayOrder ASC
)
go

create table Roadmap (
   i_Roadmap            bigint               identity,
   Stereotype           bigint               not null constraint DF_Roadmap_Stereotype default 0,
   Name                 varchar(30)          not null,
   Summary              varchar(510)         null,
   Description          nvarchar(Max)        null,
   Comment              nvarchar(Max)        null,
   isTemplate           bit                  not null constraint DF_Roadmap_isTemplate default 0,
   isDefault            bit                  not null constraint DF_Roadmap_isDefault default 0,
   isItem               bit                  not null constraint DF_Roadmap_isItem default 0,
   ExecutionState       varchar(15)          not null constraint DF_Roadmap_ExecutionState default 'Entry',
   ExecutionStage       varchar(15)          not null constraint DF_Roadmap_ExecutionStage default 'Entry',
   Owner                bigint               not null constraint DF_Roadmap_Owner default 0,
   Submap               bigint               null constraint DF_Roadmap_Submap default 0,
   Retire_Date          date                 null,
   Retire_Approach      varchar(15)          not null constraint DF_Roadmap_RetireApproach default 'Default',
   Retire_Replacement   bigint               null constraint DF_Roadmap_RetireReplacement default 0,
   GeneralStatus        varchar(15)          not null constraint DF_Roadmap_GeneralStatus default 'Normal',
   ExecutionStatus      varchar(15)          not null constraint DF_Roadmap_ExecutionStatus default 'Default'
)
go

alter table Roadmap
   add constraint i_Roadmap primary key (i_Roadmap)
go

alter table Roadmap
   add constraint n_Roadmap unique (Name, Stereotype)
go

create table RoadmapProfiles (
   i_RoadmapItem        bigint               identity,
   Stereotype           bigint               not null constraint DF_RoadmapProfiles_Stereotype default 0,
   Name                 varchar(30)          not null constraint DF_RoadmapProfiles_Name default 'Unnamed',
   Profile              bigint               not null constraint DF_RoadmapProfiles_Profile default 0,
   Roadmap              bigint               not null constraint DF_RoadmapProfiles_Roadmap default 0,
   GeneralStatus        varchar(15)          not null constraint DF_RoadmapProfiles_GeneralStatus default 'Normal'
)
go

alter table RoadmapProfiles
   add constraint i_RoadmapProfiles unique (i_RoadmapItem)
go

alter table RoadmapProfiles
   add constraint n_RoadmapProfiles unique (Stereotype, Profile, Roadmap)
go

create table RoadmapStep (
   i_RoadmapStep        bigint               identity(1, 1),
   Roadmap              bigint               not null constraint DF_RoadmapStep_Roadmap default 0,
   i_Roadmap            bigint               not null constraint DF_RoadmapStep_iRoadmap default 0,
   Classification       varchar(30)          not null constraint DF_RoadmapStep_Classification default 'Default',
   Name                 varchar(30)          not null,
   Summary              varchar(510)         null,
   Description          nvarchar(Max)        null,
   Comment              nvarchar(Max)        null,
   Deliverables         nvarchar(Max)        null,
   Artifacts            nvarchar(Max)        null,
   ExecutionStatus      varchar(15)          not null constraint DF_RoadmapStep_ExecutionStatus default 'Default',
   Entry_Restrictions   nvarchar(Max)        null,
   Exit_Conditions      nvarchar(Max)        null,
   isStage              bit                  not null constraint DF_RoadmapStep_isStage default 0,
   isState              bit                  not null constraint DF_RoadmapStep_isState default 0,
   h_Node               AS (([t_Node].[ToString]())),
   h_Parent             AS (([t_Node].[GetAncestor]((1)).ToString())),
   h_Value_Bigint       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   h_Value_String       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   t_Tree               bigint               not null constraint DF_RoadmapStep_tTree default 0,
   t_Node               hierarchyid          not null constraint DF_RoadmapStep_tNode default '/',
   GeneralStatus        varchar(15)          not null constraint DF_RoadmapStep_GeneralStatus default 'Normal'
)
go

alter table RoadmapStep
   add constraint i_RoadmapProcess primary key (i_RoadmapStep)
go

alter table RoadmapStep
   add constraint h_RoadmapStep unique (t_Tree, t_Node)
go

create table RoadmapStepClassification (
   RoadmapStepClassification varchar(30)          not null constraint DF_RoadmapStepClassification_RoadmapStepClassification default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table RoadmapStepClassification
   add constraint CKC_RoadmapStepClassification_DisplayOrder check (DisplayOrder >= 1)
go

alter table RoadmapStepClassification
   add constraint n_RoadmapStepClassification primary key (RoadmapStepClassification)
go

create unique index Index_1 on RoadmapStepClassification (
DisplayOrder ASC
)
go

create table Server (
   i_Server             bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_Server_Stereotype default 0,
   Name                 varchar(30)          not null,
   Profile              bigint               not null constraint DF_Server_Profile default 0,
   Roadmap              bigint               not null constraint DF_Server_Roadmap default 0,
   NetworkName          varchar(62)          not null,
   IP                   varchar(15)          null,
   HardwareServer       bigint               null constraint DF_Server_HardwareServer default 0,
   GeneralStatus        varchar(15)          not null constraint DF_Server_GeneralStatus default 'Normal'
)
go

alter table Server
   add constraint i_Server primary key (i_Server)
go

alter table Server
   add constraint n_Name unique (Name, Stereotype)
go

alter table Server
   add constraint n_ServerNetworkName unique (NetworkName, Stereotype)
go

create table ServerHardware (
   i_HardwareServer     bigint               identity(1, 1),
   Stereotype           bigint               not null constraint DF_ServerHardware_Stereotype default 0,
   Name                 varchar(30)          not null,
   Profile              bigint               not null constraint DF_ServerHardware_Profile default 0,
   Roadmap              bigint               not null constraint DF_ServerHardware_Roadmap default 0,
   NetworkName          varchar(15)          null,
   Location             bigint               not null constraint DF_ServerHardware_Location default 0,
   GeneralStatus        varchar(15)          not null constraint DF_ServerHardware_GeneralStatus default 'Normal'
)
go

alter table ServerHardware
   add constraint i_ServerHardware primary key (i_HardwareServer)
go

alter table ServerHardware
   add constraint n_ServerHardwareName unique (Name, Stereotype)
go

create table ServiceLevelAvailability (
   ServiceLevelAvailability varchar(15)          not null constraint DF_ServiceLevelAvailability_ServiceLevelAvailability default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ServiceLevelAvailability
   add constraint CKC_ServiceLevelAvailability_DisplayOrder check (DisplayOrder >= 1)
go

alter table ServiceLevelAvailability
   add constraint n_ServiceLevelAvailability primary key (ServiceLevelAvailability)
go

create unique index Index_1 on ServiceLevelAvailability (
DisplayOrder ASC
)
go

create table ServiceLevelRecovery (
   ServiceLevelRecovery varchar(15)          not null constraint DF_ServiceLevelRecovery_ServiceLevelRecovery default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ServiceLevelRecovery
   add constraint CKC_ServiceLevelRecovery_DisplayOrder check (DisplayOrder >= 1)
go

alter table ServiceLevelRecovery
   add constraint n_ServiceLevelRecovery primary key (ServiceLevelRecovery)
go

create unique index Index_1 on ServiceLevelRecovery (
DisplayOrder ASC
)
go

create table ServiceLevelRestore (
   ServiceLevelRestore  varchar(15)          not null constraint DF_ServiceLevelRestore_ServiceLevelRestore default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ServiceLevelRestore
   add constraint CKC_ServiceLevelRestore_DisplayOrder check (DisplayOrder >= 1)
go

alter table ServiceLevelRestore
   add constraint n_ServiceLevelRestore primary key (ServiceLevelRestore)
go

create unique index Index_1 on ServiceLevelRestore (
DisplayOrder ASC
)
go

create table ServiceLevelSupport (
   ServiceLevelSupport  varchar(15)          not null constraint DF_ServiceLevelSupport_ServiceLevelSupport default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table ServiceLevelSupport
   add constraint CKC_ServiceLevelSupport_DisplayOrder check (DisplayOrder >= 1)
go

alter table ServiceLevelSupport
   add constraint n_ServiceLevelSupport primary key (ServiceLevelSupport)
go

create unique index Index_1 on ServiceLevelSupport (
DisplayOrder ASC
)
go

create table SupportStatus (
   SupportStatus        varchar(15)          not null constraint DF_SupportStatus_SupportStatus default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table SupportStatus
   add constraint CKC_SupportStatus_DisplayOrder check (DisplayOrder >= 1)
go

alter table SupportStatus
   add constraint n_SupportStatus primary key (SupportStatus)
go

create unique index Index_1 on SupportStatus (
DisplayOrder ASC
)
go

create table SupportType (
   SupportType          varchar(15)          not null constraint DF_SupportType_SupportType default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table SupportType
   add constraint CKC_SupportType_DisplayOrder check (DisplayOrder >= 1)
go

alter table SupportType
   add constraint n_SupportType primary key (SupportType)
go

create unique index Index_1 on SupportType (
DisplayOrder ASC
)
go

create table Technology (
   i_Technology         bigint               identity(1, 1),
   Classification       varchar(30)          not null constraint DF_Technology_Classification default 'Default',
   Name                 varchar(30)          not null,
   Roadmap              bigint               not null constraint DF_Technology_Roadmap default 0,
   isProduct            bit                  not null constraint DF_Technology_isProduct default 0,
   h_Node               AS (([t_Node].[ToString]())),
   h_Parent             AS (([t_Node].[GetAncestor]((1)).ToString())),
   h_Value_Bigint       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   h_Value_String       AS ((CONVERT([bigint],substring([t_Node].[ToString](),len([t_Node].[GetAncestor]((1)).ToString())+(1),(len([t_Node].[ToString]())-len([t_Node].[GetAncestor]((1)).ToString()))-(1))))),
   t_Tree               bigint               not null constraint DF_Technology_tTree default 0,
   t_Node               hierarchyid          not null constraint DF_Technology_tNode default '/',
   GeneralStatus        varchar(15)          not null constraint DF_Technology_GeneralStatus default 'Normal',
   ArchitectureType     varchar(15)          not null constraint DF_Technology_ArchitectureType default 'Default',
   LifecycleStage       varchar(15)          not null constraint DF_Technology_LifecycleStage default 'Default',
   LifecycleState       varchar(15)          not null constraint DF_Technology_LifecycleState default 'Default'
)
go

alter table Technology
   add constraint i_Technology primary key (i_Technology)
go

alter table Technology
   add constraint h_Technology unique (t_Node, t_Tree)
go

create table TechnologyClassification (
   TechnologyClassification varchar(30)          not null constraint DF_TechnologyClassification_TechnologyClassification default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table TechnologyClassification
   add constraint CKC_TechnologyClassification_DisplayOrder check (DisplayOrder >= 1)
go

alter table TechnologyClassification
   add constraint n_TechnologyClassification primary key (TechnologyClassification)
go

create unique index Index_1 on TechnologyClassification (
DisplayOrder ASC
)
go

create table Version (
   Version              varchar(15)          not null constraint DF_Version_Version default 'Default',
   Description          nvarchar(Max)        null,
   DisplayOrder         int                  not null
)
go

alter table Version
   add constraint CKC_Version_DisplayOrder check (DisplayOrder >= 1)
go

alter table Version
   add constraint n_Version primary key (Version)
go

create unique index Index_1 on Version (
DisplayOrder ASC
)
go

alter table Application
   add constraint FK_Application_ApplicationType foreign key (ApplicationType)
      references ApplicationType (ApplicationType)
go

alter table Application
   add constraint FK_Application_BusinessApplicationManager foreign key (Business_ApplicationManager)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_BusinessOperationsManager foreign key (Business_OperationsManager)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_BusinessProductManager foreign key (Business_ProductManager)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_BusinessUnit foreign key (BusinessUnit)
      references BusinessUnit (i_BusinessUnit)
go

alter table Application
   add constraint FK_Application_DownThreshold foreign key (DownThreshold)
      references DownThreshold (DownThreshold)
go

alter table Application
   add constraint FK_Application_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Application
   add constraint FK_Application_MissionLevel foreign key (MissionLevel)
      references MissionLevel (MissionLevel)
go

alter table Application
   add constraint FK_Application_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table Application
   add constraint FK_Application_RecoveryLevel foreign key (RecoveryLevel)
      references RecoveryLevel (RecoveryLevel)
go

alter table Application
   add constraint FK_Application_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Application
   add constraint FK_Application_TechApplicationManager foreign key (Tech_ApplicationManager)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_TechCustomerAgent foreign key (Tech_CustomerAgent)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_TechOperationsManager foreign key (Tech_OperationsManager)
      references Person (i_Person)
go

alter table Application
   add constraint FK_Application_TechProductManager foreign key (Tech_ProductManager)
      references Person (i_Person)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_Application foreign key (Application)
      references Application (i_Application)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_DeployDevelopment foreign key (Deploy_Development)
      references Server (i_Server)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_DeployProduction foreign key (Deploy_Production)
      references Server (i_Server)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_DeployRecovery foreign key (Deploy_Recovery)
      references Server (i_Server)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_DeployStaging foreign key (Deploy_Staging)
      references Server (i_Server)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_DeployTest foreign key (Deploy_Test)
      references Server (i_Server)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_EnvironmentCurrent foreign key (Environment_Current)
      references Environment (i_Environment)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_EnvironmentTarget foreign key (Environment_Target)
      references Environment (i_Environment)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyApplicationServer foreign key (Technology_ApplicationServer)
      references Technology (i_Technology)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyClient foreign key (Technology_Client)
      references Technology (i_Technology)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyDatabasePlatform foreign key (Technology_DatabasePlatform)
      references Technology (i_Technology)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyDevelopmentLanguage foreign key (Technology_DevelopmentLanguage)
      references Technology (i_Technology)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyORM foreign key (Technology_ORM)
      references Technology (i_Technology)
go

alter table ApplicationComponent
   add constraint FK_ApplicationComponent_TechnologyPlatformStack foreign key (Technology_PlatformStack)
      references Technology (i_Technology)
go

alter table ApplicationUserGroup
   add constraint FK_ApplicationUserGroup_Application foreign key (Application)
      references Application (i_Application)
go

alter table ApplicationUserGroup
   add constraint FK_ApplicationUserGroup_Distribution foreign key (Distribution)
      references Distribution (Distribution)
go

alter table ApplicationUserGroup
   add constraint FK_ApplicationUserGroup_Organization foreign key (Organization)
      references Organization (i_Organization)
go

alter table BusinessService
   add constraint FK_BusinessService_BusinessServiceType foreign key (BusinessServiceType)
      references BusinessServiceType (BusinessServiceType)
go

alter table BusinessService
   add constraint FK_BusinessService_BusinessUnit foreign key (BusinessUnit)
      references BusinessUnit (i_BusinessUnit)
go

alter table BusinessServiceApplication
   add constraint FK_BusinessServiceApplication_Application foreign key (Application)
      references Application (i_Application)
go

alter table BusinessServiceApplication
   add constraint FK_BusinessServiceApplication_BusinessService foreign key (BusinessService)
      references BusinessService (i_BusinessService)
go

alter table BusinessServiceApplication
   add constraint FK_BusinessServiceApplication_MissionLevel foreign key (MissionLevel)
      references MissionLevel (MissionLevel)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ApplicationProfilePerson foreign key (ApplicationProfilePerson)
      references Person (i_Person)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ApplicationProfileStatus foreign key (ApplicationProfileStatus)
      references BusinessProfileStatus (BusinessProfileStatus)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_BusinessLeader foreign key (BusinessLeader)
      references Person (i_Person)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_BusinessUnitType foreign key (BusinessUnitType)
      references BusinessUnitType (BusinessUnitType)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_OperationsLeader foreign key (OperationsLeader)
      references Person (i_Person)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_Organization foreign key (Organization)
      references Organization (i_Organization)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ServerProfilePerson foreign key (ServerProfilePerson)
      references Person (i_Person)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ServerProfileStatus foreign key (ServerProfileStatus)
      references BusinessProfileStatus (BusinessProfileStatus)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ServiceProfileStatus foreign key (ServiceProfileStatus)
      references BusinessProfileStatus (BusinessProfileStatus)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_ServicesProfilePerson foreign key (ServicesProfilePerson)
      references Person (i_Person)
go

alter table BusinessUnit
   add constraint FK_BusinessUnit_TechnologyLeader foreign key (TechnologyLeader)
      references Person (i_Person)
go

alter table ChangeCost
   add constraint FK_ChangeCost_ChangeCostCategory foreign key (ChangeCostCategory)
      references ChangeCostCategory (ChangeCostCategory)
go

alter table ChangeCost
   add constraint FK_ChangeCost_ChangeCostStatus foreign key (ChangeCostStatus)
      references ChangeCostStatus (ChangeCostStatus)
go

alter table ChangeCost
   add constraint FK_ChangeCost_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table ChangeTicket
   add constraint FK_ChangeTicket_ChangeTicketStatus foreign key (ChangeTicketStatus)
      references ChangeTicketStatus (ChangeTicketStatus)
go

alter table ChangeTicket
   add constraint FK_ChangeTicket_ChangeTicketSystem foreign key (ChangeTicketSystem)
      references ChangeTicketSystem (ChangeTicketSystem)
go

alter table ChangeTicket
   add constraint FK_ChangeTicket_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table ChangeTicket
   add constraint FK_ChangeTicket_TicketOwner foreign key (TicketOwner)
      references Person (i_Person)
go

alter table Environment
   add constraint FK_Environment_Edition foreign key (Edition)
      references Edition (Edition)
go

alter table Environment
   add constraint FK_Environment_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Environment
   add constraint FK_Environment_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Environment
   add constraint FK_Environment_Version foreign key (Version)
      references Version (Version)
go

alter table EnvironmentTechnology
   add constraint FK_EnvironmentTechnology_Environment foreign key (Environment)
      references Environment (i_Environment)
go

alter table EnvironmentTechnology
   add constraint FK_EnvironmentTechnology_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table EnvironmentTechnology
   add constraint FK_EnvironmentTechnology_Technology foreign key (Technology)
      references Technology (i_Technology)
go

alter table OperatingCost
   add constraint FK_OperatingCost_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table OperatingCost
   add constraint FK_OperatingCost_OperatingCostCategory foreign key (OperatingCostCategory)
      references OperatingCostCategory (OperatingCostCategory)
go

alter table OperatingCost
   add constraint FK_OperatingCost_OperatingCostStatus foreign key (OperatingCostStatus)
      references OperatingCostStatus (OperatingCostStatus)
go

alter table OperatingCost
   add constraint FK_OperatingCost_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table Organization
   add constraint FK_Organization_Classification foreign key (Classification)
      references OrganizationClassification (OrganizationClassification)
go

alter table Organization
   add constraint FK_Organization_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Organization
   add constraint FK_Organization_OrganizationLeader foreign key (OrganizationLeader)
      references Person (i_Person)
go

alter table Organization
   add constraint FK_Organization_OrganizationType foreign key (OrganizationType)
      references OrganizationType (OrganizationType)
go

alter table Organization
   add constraint FK_Organization_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Organization
   add constraint FK_Organization_TechnologyLeader foreign key (TechnologyLeader)
      references Person (i_Person)
go

alter table Person
   add constraint FK_Person_EmploymentType foreign key (EmploymentType)
      references EmploymentType (EmploymentType)
go

alter table Person
   add constraint FK_Person_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Person
   add constraint FK_Person_JobTitle foreign key (JobTitle)
      references JobTitle (JobTitle)
go

alter table Product
   add constraint FK_Product_DevelopmentStage foreign key (DevelopmentStage)
      references DevelopmentStage (DevelopmentStage)
go

alter table Product
   add constraint FK_Product_DevelopmentType foreign key (DevelopmentType)
      references DevelopmentType (DevelopmentType)
go

alter table Product
   add constraint FK_Product_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Product
   add constraint FK_Product_LicenseType foreign key (LicenseType)
      references LicenseType (LicenseType)
go

alter table Product
   add constraint FK_Product_PackageType foreign key (PackageType)
      references PackageType (PackageType)
go

alter table Product
   add constraint FK_Product_Producer foreign key (Producer)
      references Organization (i_Organization)
go

alter table Product
   add constraint FK_Product_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table Product
   add constraint FK_Product_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Profile
   add constraint FK_Profile_ChangeManager foreign key (Change_Manager)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_ChangeStatus foreign key (Change_Status)
      references ChangeStatus (ChangeStatus)
go

alter table Profile
   add constraint FK_Profile_ContactBusiness foreign key (Contact_Business)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_ContactTechnology foreign key (Contact_Technology)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_CurrentStatus foreign key (Current_Status)
      references GeneralStatus (GeneralStatus)
go

alter table Profile
   add constraint FK_Profile_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Profile
   add constraint FK_Profile_OwnerBusiness foreign key (Owner_Business)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_OwnerFunding foreign key (Owner_Funding)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_OwnerTechnology foreign key (Owner_Technology)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_ProfileManager foreign key (Profile_Manager)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_ProfileStatus foreign key (Profile_Status)
      references GeneralStatus (GeneralStatus)
go

alter table Profile
   add constraint FK_Profile_ServiceLevelAvailability foreign key (ServiceLevel_Availability)
      references ServiceLevelAvailability (ServiceLevelAvailability)
go

alter table Profile
   add constraint FK_Profile_ServiceLevelRecovery foreign key (ServiceLevel_Recovery)
      references ServiceLevelRecovery (ServiceLevelRecovery)
go

alter table Profile
   add constraint FK_Profile_ServiceLevelRestore foreign key (ServiceLevel_Restore)
      references ServiceLevelRestore (ServiceLevelRestore)
go

alter table Profile
   add constraint FK_Profile_ServiceLevelSupport foreign key (ServiceLevel_Support)
      references ServiceLevelSupport (ServiceLevelSupport)
go

alter table Profile
   add constraint FK_Profile_SpecCpu foreign key (Spec_Cpu)
      references Cpu (CPU)
go

alter table Profile
   add constraint FK_Profile_SpecDisk foreign key (Spec_Disk)
      references [Disk] ([Disk])
go

alter table Profile
   add constraint FK_Profile_SpecFormFactor foreign key (Spec_FormFactor)
      references FormFactor (FormFactor)
go

alter table Profile
   add constraint FK_Profile_SpecOperatingSystem foreign key (Spec_OperatingSystem)
      references OperatingSystem (OperatingSystem)
go

alter table Profile
   add constraint FK_Profile_SpecRam foreign key (Spec_Ram)
      references Ram (Ram)
go

alter table Profile
   add constraint FK_Profile_SpecTechnology foreign key (Spec_Technology)
      references Technology (i_Technology)
go

alter table Profile
   add constraint FK_Profile_SupportApplication foreign key (Support_Application)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_SupportPlatform foreign key (Support_Platform)
      references Person (i_Person)
go

alter table Profile
   add constraint FK_Profile_SupportStatus foreign key (Support_Status)
      references SupportStatus (SupportStatus)
go

alter table Profile
   add constraint FK_Profile_SupportType foreign key (Support_Type)
      references SupportType (SupportType)
go

alter table Profile
   add constraint FK_Profile_Technology foreign key (Technology)
      references Technology (i_Technology)
go

alter table Roadmap
   add constraint FK_Roadmap_ExecutionStage foreign key (ExecutionStage)
      references ExecutionStage (ExecutionStage)
go

alter table Roadmap
   add constraint FK_Roadmap_ExecutionState foreign key (ExecutionState)
      references ExecutionState (ExecutionState)
go

alter table Roadmap
   add constraint FK_Roadmap_ExecutionStatus foreign key (ExecutionStatus)
      references ExecutionStatus (ExecutionStatus)
go

alter table Roadmap
   add constraint FK_Roadmap_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Roadmap
   add constraint FK_Roadmap_RetireApproach foreign key (Retire_Approach)
      references RetireApproach (RetireApproach)
go

alter table RoadmapProfiles
   add constraint FK_RoadmapProfiles_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table RoadmapProfiles
   add constraint FK_RoadmapProfiles_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table RoadmapProfiles
   add constraint FK_RoadmapProfiles_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table RoadmapStep
   add constraint FK_RoadmapStep_Classification foreign key (Classification)
      references RoadmapStepClassification (RoadmapStepClassification)
go

alter table RoadmapStep
   add constraint FK_RoadmapStep_ExecutionStatus foreign key (ExecutionStatus)
      references ExecutionStatus (ExecutionStatus)
go

alter table RoadmapStep
   add constraint FK_RoadmapStep_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table RoadmapStep
   add constraint FK_RoadmapStep_iRoadmap foreign key (i_Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Server
   add constraint FK_Server_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Server
   add constraint FK_Server_HardwareServer foreign key (HardwareServer)
      references ServerHardware (i_HardwareServer)
go

alter table Server
   add constraint FK_Server_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table Server
   add constraint FK_Server_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table ServerHardware
   add constraint FK_ServerHardware_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table ServerHardware
   add constraint FK_ServerHardware_Location foreign key (Location)
      references Location (i_Location)
go

alter table ServerHardware
   add constraint FK_ServerHardware_Profile foreign key (Profile)
      references Profile (i_Profile)
go

alter table ServerHardware
   add constraint FK_ServerHardware_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go

alter table Technology
   add constraint FK_Technology_ArchitectureType foreign key (ArchitectureType)
      references ArchitectureType (ArchitectureType)
go

alter table Technology
   add constraint FK_Technology_Classification foreign key (Classification)
      references TechnologyClassification (TechnologyClassification)
go

alter table Technology
   add constraint FK_Technology_GeneralStatus foreign key (GeneralStatus)
      references GeneralStatus (GeneralStatus)
go

alter table Technology
   add constraint FK_Technology_LifecycleStage foreign key (LifecycleStage)
      references LifecycleStage (LifecycleStage)
go

alter table Technology
   add constraint FK_Technology_LifecycleState foreign key (LifecycleState)
      references LifecycleState (LifecycleState)
go

alter table Technology
   add constraint FK_Technology_Roadmap foreign key (Roadmap)
      references Roadmap (i_Roadmap)
go
