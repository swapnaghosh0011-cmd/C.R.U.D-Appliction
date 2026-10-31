-- H2 2.4.240; 
SET DB_CLOSE_DELAY -1;         
;              
CREATE USER IF NOT EXISTS "SA" SALT 'f72657f48b85e811' HASH '49705ba3c0e048680c9d8836643145e6947b63e5304ad12a5d5e407fda230d89' ADMIN;          
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_CONNECT_STATE" CASCADE;            
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_DEVICE_CREDENTIAL" CASCADE;        
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_FREE_TIER_PERIOD" CASCADE;         
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_FREE_TIER_USAGE" CASCADE;          
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_METERED_SIGNATURE" CASCADE;        
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_SYNC_STATE" CASCADE;               
DROP TABLE IF EXISTS "PUBLIC"."ACCOUNT_LINK_USAGE_COUNTER" CASCADE;            
DROP TABLE IF EXISTS "PUBLIC"."API_KEY_DAILY_USAGE" CASCADE;   
DROP TABLE IF EXISTS "PUBLIC"."API_KEYS" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."AUDIT_EVENTS" CASCADE;          
DROP TABLE IF EXISTS "PUBLIC"."AUTHORITIES" CASCADE;           
DROP TABLE IF EXISTS "PUBLIC"."FILE_ENCRYPTION_KEYS" CASCADE;  
DROP TABLE IF EXISTS "PUBLIC"."FILE_RUN_EVENTS" CASCADE;       
DROP TABLE IF EXISTS "PUBLIC"."FILE_SHARE_ACCESSES" CASCADE;   
DROP TABLE IF EXISTS "PUBLIC"."FILE_SHARES" CASCADE;           
DROP TABLE IF EXISTS "PUBLIC"."FOLDERS" CASCADE;               
DROP TABLE IF EXISTS "PUBLIC"."INTEGRATION_CONFIGS" CASCADE;   
DROP TABLE IF EXISTS "PUBLIC"."INVITE_TOKENS" CASCADE;         
DROP TABLE IF EXISTS "PUBLIC"."JWT_SIGNING_KEYS" CASCADE;      
DROP TABLE IF EXISTS "PUBLIC"."ORG_OWNER" CASCADE;             
DROP TABLE IF EXISTS "PUBLIC"."PARTICIPANT_NOTIFICATIONS" CASCADE;             
DROP TABLE IF EXISTS "PUBLIC"."PERSISTENT_LOGINS" CASCADE;     
DROP TABLE IF EXISTS "PUBLIC"."POLICIES" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."POLICY_ASSETS" CASCADE;         
DROP TABLE IF EXISTS "PUBLIC"."POLICY_COMPLETED_MIGRATIONS" CASCADE;           
DROP TABLE IF EXISTS "PUBLIC"."POLICY_PROCESSED_FILES" CASCADE;
DROP TABLE IF EXISTS "PUBLIC"."POLICY_SOURCE_DOC_COUNTS" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."POLICY_SOURCE_DOC_TOTALS" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."POLICY_SOURCES" CASCADE;        
DROP TABLE IF EXISTS "PUBLIC"."RESOURCE_GRANTS" CASCADE;       
DROP TABLE IF EXISTS "PUBLIC"."SESSIONS" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."STORAGE_CLEANUP_ENTRIES" CASCADE;               
DROP TABLE IF EXISTS "PUBLIC"."STORED_FILE_BLOBS" CASCADE;     
DROP TABLE IF EXISTS "PUBLIC"."STORED_FILES" CASCADE;          
DROP TABLE IF EXISTS "PUBLIC"."TEAM_MEMBERSHIPS" CASCADE;      
DROP TABLE IF EXISTS "PUBLIC"."TEAMS" CASCADE; 
DROP TABLE IF EXISTS "PUBLIC"."TOOL_CHAIN_STATS" CASCADE;      
DROP TABLE IF EXISTS "PUBLIC"."TOOL_USAGE_STATS" CASCADE;      
DROP TABLE IF EXISTS "PUBLIC"."USER_LICENSE_SETTINGS" CASCADE; 
DROP TABLE IF EXISTS "PUBLIC"."USER_SERVER_CERTIFICATES" CASCADE;              
DROP TABLE IF EXISTS "PUBLIC"."USER_SETTINGS" CASCADE;         
DROP TABLE IF EXISTS "PUBLIC"."USERS" CASCADE; 
DROP TABLE IF EXISTS "PUBLIC"."WORKFLOW_PARTICIPANTS" CASCADE; 
DROP TABLE IF EXISTS "PUBLIC"."WORKFLOW_SESSIONS" CASCADE;     
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_CONNECT_STATE"(
    "ID" BIGINT NOT NULL,
    "AUTHORIZE_URL" CHARACTER VARYING(2048) NOT NULL,
    "CALLBACK_URL" CHARACTER VARYING(2048) NOT NULL,
    "CLAIM_SECRET" CHARACTER VARYING(128) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "EXPIRES_AT" TIMESTAMP(6) NOT NULL,
    "NONCE" CHARACTER VARYING(128) NOT NULL,
    "OWNER_ASSIGNED_AT" TIMESTAMP(6),
    "OWNER_USER_ID" BIGINT,
    "REAUTH" BOOLEAN,
    "REQUEST_ID" CHARACTER VARYING(64) NOT NULL
);    
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_CONNECT_STATE" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_B" PRIMARY KEY("ID");    
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_CONNECT_STATE;               
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_DEVICE_CREDENTIAL"(
    "ID" BIGINT NOT NULL,
    "DEVICE_ID" CHARACTER VARYING(64) NOT NULL,
    "DEVICE_SECRET" CHARACTER VARYING(128) NOT NULL,
    "ENTITLEMENT_REVOKED" BOOLEAN DEFAULT FALSE NOT NULL,
    "FLEET_USER_LIMIT" INTEGER,
    "LAST_ENTITLEMENT_SUCCESS_AT" TIMESTAMP(6) WITH TIME ZONE,
    "LINKED_AT" TIMESTAMP(6) NOT NULL,
    "TEAM_ID" BIGINT
);          
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_DEVICE_CREDENTIAL" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_A" PRIMARY KEY("ID");
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_DEVICE_CREDENTIAL;           
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_FREE_TIER_PERIOD"(
    "ID" BIGINT NOT NULL,
    "ANCHOR_AT" TIMESTAMP(6) NOT NULL,
    "PERIOD_START" TIMESTAMP(6) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL
);             
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_FREE_TIER_PERIOD" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_6" PRIMARY KEY("ID"); 
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_FREE_TIER_PERIOD;            
INSERT INTO "PUBLIC"."ACCOUNT_LINK_FREE_TIER_PERIOD"("ID", "ANCHOR_AT", "PERIOD_START", "UPDATED_AT") VALUES(1, TIMESTAMP '2026-10-31 09:58:20.109529', TIMESTAMP '2026-10-31 09:58:20.109529', TIMESTAMP '2026-10-31 09:58:20.109529');       
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_FREE_TIER_USAGE"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "CATEGORY" CHARACTER VARYING(32) NOT NULL,
    "CUMULATIVE_UNITS" BIGINT NOT NULL,
    "PERIOD_START" TIMESTAMP(6) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL
);               
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_FREE_TIER_USAGE" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_B9" PRIMARY KEY("ID"); 
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_FREE_TIER_USAGE;             
INSERT INTO "PUBLIC"."ACCOUNT_LINK_FREE_TIER_USAGE"("ID", "CATEGORY", "CUMULATIVE_UNITS", "PERIOD_START", "UPDATED_AT") VALUES(1, 'API', 6, TIMESTAMP '2026-10-31 09:58:20.109529', TIMESTAMP '2026-10-31 10:36:49.556322');   
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_METERED_SIGNATURE"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "LAST_METERED_AT" TIMESTAMP(6),
    "PERIOD_START" TIMESTAMP(6) NOT NULL,
    "SIGNATURE" CHARACTER VARYING(64) NOT NULL,
    "STEP_COUNT" INTEGER
);      
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_METERED_SIGNATURE" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_1" PRIMARY KEY("ID");
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_METERED_SIGNATURE;           
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_SYNC_STATE"(
    "ID" BIGINT NOT NULL,
    "LAST_SUCCESS_AT" TIMESTAMP(6),
    "LAST_SYNC_SEQ" BIGINT DEFAULT 0 NOT NULL
);         
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_SYNC_STATE" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_5" PRIMARY KEY("ID");       
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_SYNC_STATE;  
CREATE CACHED TABLE "PUBLIC"."ACCOUNT_LINK_USAGE_COUNTER"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CATEGORY" CHARACTER VARYING(32) NOT NULL,
    "CUMULATIVE_UNITS" BIGINT NOT NULL,
    "LAST_SYNCED_UNITS" BIGINT DEFAULT 0 NOT NULL,
    "PERIOD_START" TIMESTAMP(6) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL
);              
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_USAGE_COUNTER" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_1F" PRIMARY KEY("ID");   
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.ACCOUNT_LINK_USAGE_COUNTER;               
CREATE CACHED TABLE "PUBLIC"."API_KEY_DAILY_USAGE"(
    "API_KEY_ID" BIGINT NOT NULL,
    "EPOCH_DAY" BIGINT NOT NULL,
    "COUNT" BIGINT
);   
ALTER TABLE "PUBLIC"."API_KEY_DAILY_USAGE" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_12" PRIMARY KEY("API_KEY_ID", "EPOCH_DAY");     
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.API_KEY_DAILY_USAGE;      
INSERT INTO "PUBLIC"."API_KEY_DAILY_USAGE"("API_KEY_ID", "EPOCH_DAY", "COUNT") VALUES(1, 20756, 28);           
INSERT INTO "PUBLIC"."API_KEY_DAILY_USAGE"("API_KEY_ID", "EPOCH_DAY", "COUNT") VALUES(1, 20757, 89);           
CREATE CACHED TABLE "PUBLIC"."API_KEYS"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    "ENABLED" BOOLEAN NOT NULL,
    "KEY_HASH" CHARACTER VARYING(64) NOT NULL,
    "LAST_USED_AT" TIMESTAMP(6) WITH TIME ZONE,
    "NAME" CHARACTER VARYING(100) NOT NULL,
    "OWNER_USER_ID" BIGINT NOT NULL,
    "PREFIX" CHARACTER VARYING(32) NOT NULL,
    "REVOKED_AT" TIMESTAMP(6) WITH TIME ZONE
);          
ALTER TABLE "PUBLIC"."API_KEYS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_6A" PRIMARY KEY("ID");     
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.API_KEYS; 
INSERT INTO "PUBLIC"."API_KEYS"("ID", "CREATED_AT", "ENABLED", "KEY_HASH", "LAST_USED_AT", "NAME", "OWNER_USER_ID", "PREFIX", "REVOKED_AT") VALUES(1, TIMESTAMP WITH TIME ZONE '2026-10-30 14:49:00.250671+00', TRUE, 'c99d2c8b3836c10cb89352eec74cdbd16e0ecfaa102c29e795b6b4edd993d8bd', TIMESTAMP WITH TIME ZONE '2026-10-31 11:40:41.959332+00', 'test', 1, 'sk_20d7d8c9', NULL);           
CREATE INDEX "PUBLIC"."IDX_API_KEY_OWNER" ON "PUBLIC"."API_KEYS"("OWNER_USER_ID" NULLS FIRST); 
CREATE CACHED TABLE "PUBLIC"."AUDIT_EVENTS"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 195) NOT NULL,
    "DATA" CHARACTER VARYING,
    "PRINCIPAL" CHARACTER VARYING(255),
    "SOURCE" CHARACTER VARYING(255),
    "TIMESTAMP" TIMESTAMP(6) WITH TIME ZONE,
    "TYPE" CHARACTER VARYING(255)
);            
ALTER TABLE "PUBLIC"."AUDIT_EVENTS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_C" PRIMARY KEY("ID");  
-- 119 +/- SELECT COUNT(*) FROM PUBLIC.AUDIT_EVENTS;           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(1, '{"newOwnerUserId":1,"source":"RECONCILE"}', 'system:org-owner', NULL, TIMESTAMP WITH TIME ZONE '2026-10-30 09:14:13.54607+00', 'ORG_OWNERSHIP_CHANGE');               
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(33, '{"principal":"admin","path":"/api/v1/settings/update-enable-analytics","formParams":{"enabled":["false"]},"requestId":"ce759ba4-03d4-40ed-9e55-f9faee4a71e7","__origin":"WEB","clientIp":"172.17.0.1","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":68,"timestamp":"2026-10-30T14:47:26.159702960Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 14:47:26.228168+00', 'PDF_PROCESS');   
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(34, '{"principal":"admin","path":"/api/v1/proprietary/ui-data/infrastructure/api-keys","requestId":"1de51b54-5490-4182-a2d9-e1e0009184d1","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","sessionId":"node0hafr4n5uxq6axq9s9hwe886413","httpMethod":"POST","outcome":"success","latencyMs":9,"timestamp":"2026-10-30T14:49:00.246027191Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 14:49:00.255666+00', 'PDF_PROCESS');              
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(35, '{"principal":"admin","path":"/mcp","requestId":"3d53f300-3a74-49fb-a689-c3685a619bde","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T15:00:49.285578761Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:00:49.286555+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(36, '{"principal":"admin","path":"/mcp","requestId":"ac8dcc23-66af-4acf-bc0f-1dea72fd775a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:00:49.336208723Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:00:49.336331+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(37, '{"principal":"admin","path":"/mcp","requestId":"ced3373f-2d9a-4327-b838-3b77c79edb72","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:00:49.384434716Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:00:49.384591+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(38, '{"principal":"admin","path":"/mcp","requestId":"286fe60d-dbb5-4c9c-a1f4-bbab5a47b324","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":3,"timestamp":"2026-10-30T15:00:49.392911351Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:00:49.39502+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(39, '{"principal":"admin","path":"/mcp","requestId":"cb2293d8-03fe-48c7-b0d8-6735adfa1b58","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:17:35.150910599Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:17:35.150991+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(40, '{"principal":"admin","path":"/mcp","requestId":"e3bb7870-997e-403c-b7aa-7c9ac20b6b77","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:17:35.200355870Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:17:35.200433+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(41, '{"principal":"admin","path":"/mcp","requestId":"d56c3e6e-f42f-4104-9a5e-a6937249aee5","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:17:35.248119537Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:17:35.24818+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(42, '{"principal":"admin","path":"/mcp","requestId":"27fd5b0a-3824-4534-95ab-71424bee468a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T15:17:35.255699275Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:17:35.256425+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(43, '{"principal":"admin","path":"/mcp","requestId":"1499779e-b596-4042-9be9-8a077a798e83","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T15:19:11.726956548Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:19:11.72707+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(44, '{"principal":"admin","path":"/mcp","requestId":"077abed8-599e-44f3-98e9-a2848bae1c3f","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:19:11.776455814Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:19:11.776589+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(45, '{"principal":"admin","path":"/mcp","requestId":"71363eff-76f8-452f-bcdc-8fd45a4eebe3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T15:19:11.823924236Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:19:11.823983+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(46, '{"principal":"admin","path":"/mcp","requestId":"8c9821ee-a408-4602-b6fd-4d5980d6aa13","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T15:19:11.835054078Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 15:19:11.836074+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(47, '{"principal":"admin","path":"/mcp","requestId":"1404926e-2dcb-4c9d-b269-6a13f88029d9","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:00:48.879677964Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:00:48.879752+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(48, '{"principal":"admin","path":"/mcp","requestId":"77d3a48f-5bb9-488a-abc7-1508822a3e2e","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:00:48.926863534Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:00:48.926944+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(49, '{"principal":"admin","path":"/mcp","requestId":"4f0373c6-1816-4703-9d82-4febe9130404","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:00:48.975192054Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:00:48.975255+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(50, '{"principal":"admin","path":"/mcp","requestId":"a0d44dc2-260c-4cf8-b6eb-08cc6b931b09","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:00:48.983004536Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:00:48.983735+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(51, '{"principal":"admin","path":"/mcp","requestId":"576b5be1-d180-47d8-926b-853631fd1656","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T16:01:40.988938906Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:01:40.989027+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(52, '{"principal":"admin","path":"/mcp","requestId":"1a817f91-ab1b-4572-8de0-544020d8c2e3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:01:41.036195263Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:01:41.036291+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(53, '{"principal":"admin","path":"/mcp","requestId":"38b47b79-d2a1-47a3-8edd-aa169b9eccdd","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:01:41.084638833Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:01:41.084706+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(54, '{"principal":"admin","path":"/mcp","requestId":"8db78e07-a55d-4151-8c05-710bc40e795f","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T16:01:41.092568249Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:01:41.093541+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(55, '{"principal":"admin","path":"/mcp","requestId":"2d6f4838-47b9-4dc8-aacc-8350496ade75","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:02:19.503663993Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:02:19.503747+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(56, '{"principal":"admin","path":"/mcp","requestId":"a9161fe1-4b57-44ea-8fa3-982ed32614c4","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:02:19.551767422Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:02:19.551857+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(57, '{"principal":"admin","path":"/mcp","requestId":"d49a29ab-5ea7-4c4c-8e74-162b703e692e","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:02:19.598420463Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:02:19.59848+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(58, '{"principal":"admin","path":"/mcp","requestId":"00654776-ddec-49c7-af91-5a332640a296","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:02:19.608074089Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:02:19.608914+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(59, '{"principal":"admin","path":"/mcp","requestId":"263aa8a2-5e9b-47f2-99ed-2e67db6385fc","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:03:08.303422866Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:03:08.303505+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(60, '{"principal":"admin","path":"/mcp","requestId":"3aabcbfd-fccd-42ee-b403-089d7257e98c","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:03:08.352062454Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:03:08.352145+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(61, '{"principal":"admin","path":"/mcp","requestId":"f0303d5c-de08-4dc4-8dc2-f7221d9fa92a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-30T16:03:08.399514694Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:03:08.399571+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(62, '{"principal":"admin","path":"/mcp","requestId":"1d997224-bb55-48cc-98c6-09aebeb8ccf7","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-30T16:03:08.406321960Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-30 16:03:08.407097+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(65, '{"principal":"admin","path":"/mcp","requestId":"5c9fb806-0291-4123-b110-4a45767fd4ec","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:29:14.577890508Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:29:14.578913+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(66, '{"principal":"admin","path":"/mcp","requestId":"fcc22ad8-fca3-47c0-9e2b-49b82988d8eb","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:29:14.598386581Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:29:14.598533+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(67, '{"principal":"admin","path":"/mcp","requestId":"89ced7c3-c65a-46f0-8dfb-364a12f2e4bc","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:29:14.652652357Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:29:14.65275+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(68, '{"principal":"admin","path":"/mcp","requestId":"f87e2264-8ae9-4c19-8607-98d38663e85d","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":2,"timestamp":"2026-10-31T03:29:14.666670268Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:29:14.668495+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(69, '{"principal":"admin","path":"/mcp","requestId":"6cc28019-6e27-4e55-9e92-4e86ae4c6c9b","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:42:48.661144833Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:42:48.661294+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(70, '{"principal":"admin","path":"/mcp","requestId":"9af514fc-5e03-4a14-b798-ef9bcd5ea3a0","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:42:48.717357145Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:42:48.717534+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(71, '{"principal":"admin","path":"/mcp","requestId":"8e1d3572-da0d-493c-9e2c-e2817e0a4efe","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:42:48.774687273Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:42:48.774773+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(72, '{"principal":"admin","path":"/mcp","requestId":"458fc79a-2ea3-4938-b3ea-5e13551ea62b","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:42:48.790605964Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:42:48.79174+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(73, '{"principal":"admin","path":"/mcp","requestId":"4d07b93d-76c3-45bb-957c-950bdb00b875","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:47:57.033904049Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:47:57.034026+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(74, '{"principal":"admin","path":"/mcp","requestId":"96242b16-a5ab-411c-b09f-29a0e5823bf5","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:47:57.085488378Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:47:57.08558+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(75, '{"principal":"admin","path":"/mcp","requestId":"584905da-ab61-4d07-8641-183bf1097394","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:47:57.137317098Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:47:57.137383+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(76, '{"principal":"admin","path":"/mcp","requestId":"ea37202c-1623-47ae-8b74-9efc3d7f2486","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:47:57.150452097Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:47:57.151463+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(77, '{"principal":"admin","path":"/mcp","requestId":"9e6cf5c0-fb23-434a-87c9-c96d697f9734","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:48:47.632822419Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:48:47.6329+00', 'PDF_PROCESS');             
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(78, '{"principal":"admin","path":"/mcp","requestId":"dc3e3ae1-93f1-4ff5-a44f-f47adbea8ab6","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:48:47.686348892Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:48:47.686474+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(79, '{"principal":"admin","path":"/mcp","requestId":"0e997dbb-37cd-482c-827c-01cf5ab6daca","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:48:47.741227925Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:48:47.741326+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(80, '{"principal":"admin","path":"/mcp","requestId":"fcc05129-aff1-4f03-bed9-2ea7467e6d22","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:48:47.756320964Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:48:47.757408+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(81, '{"principal":"admin","path":"/mcp","requestId":"cf6fc6c5-1f1a-4823-949a-b95fe0b46967","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:52:56.941983812Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:52:56.942088+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(82, '{"principal":"admin","path":"/mcp","requestId":"11df125f-340b-4e7e-8e15-716837c1d426","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:52:56.995480903Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:52:56.995606+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(83, '{"principal":"admin","path":"/mcp","requestId":"ae95041f-9bfc-489f-b73d-181bee6414f0","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:52:57.055028610Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:52:57.055133+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(84, '{"principal":"admin","path":"/mcp","requestId":"2b112773-9908-4bf3-896c-0e7725aa2e60","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:52:57.071520143Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:52:57.072828+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(85, '{"principal":"admin","path":"/mcp","requestId":"1e47c7f8-fdcc-4e7c-8fcb-11a0a58dd635","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:59:50.883139065Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:59:50.883257+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(86, '{"principal":"admin","path":"/mcp","requestId":"75273ebe-838e-47d5-8bcc-2cf99c354bee","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:59:50.936131839Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:59:50.93624+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(87, '{"principal":"admin","path":"/mcp","requestId":"e0382162-c50a-4d49-bb54-d24c4ca5d8c0","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T03:59:50.988677802Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:59:50.988936+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(88, '{"principal":"admin","path":"/mcp","requestId":"0296abf5-cd69-4d3b-b3af-fd2d4708e19a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T03:59:51.003561588Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 03:59:51.004527+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(89, '{"principal":"admin","path":"/mcp","requestId":"6d961db5-7821-4f4b-a8cf-b7a5ff54edeb","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:00:20.828175117Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:00:20.828276+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(90, '{"principal":"admin","path":"/mcp","requestId":"9d9c3ce5-581d-475f-bf38-61d085083bce","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:00:20.885397247Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:00:20.885501+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(91, '{"principal":"admin","path":"/mcp","requestId":"60c11f54-d7aa-401a-87ad-c964fac68016","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:00:20.942307451Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:00:20.942389+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(92, '{"principal":"admin","path":"/mcp","requestId":"641f8b5e-b58d-4186-bf19-c7e7c7e11946","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:00:20.956896097Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:00:20.957963+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(93, '{"principal":"admin","path":"/mcp","requestId":"333d5a70-ff2f-4de1-a71e-e006c96838d7","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:01:59.744727624Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:01:59.744826+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(94, '{"principal":"admin","path":"/mcp","requestId":"4502be7f-37a7-4c43-824e-1b2b38c1ff2a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:01:59.796355591Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:01:59.796436+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(95, '{"principal":"admin","path":"/mcp","requestId":"4b337371-cc30-4902-be2d-3ba9e0e8abc3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:01:59.848355188Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:01:59.848415+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(96, '{"principal":"admin","path":"/mcp","requestId":"eab76d8e-fdeb-4829-8a08-e199c512f1ba","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:01:59.859320945Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:01:59.859936+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(97, '{"principal":"admin","path":"/mcp","requestId":"d03c6ddb-f7be-4a1f-96d3-47e748a827e1","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:03:05.939321029Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:03:05.939418+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(98, '{"principal":"admin","path":"/mcp","requestId":"7f2e0b51-7396-4a9e-b9af-dc72a15886d3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:03:05.995511470Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:03:05.995688+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(99, '{"principal":"admin","path":"/mcp","requestId":"537cc7f8-ae21-462c-9b8b-7b12f420b05f","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:03:06.049657013Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:03:06.049745+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(100, '{"principal":"admin","path":"/mcp","requestId":"acdcde2c-8c44-4630-a5c2-e7af1f51a16e","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:03:06.060904187Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:03:06.061484+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(101, '{"principal":"admin","path":"/mcp","requestId":"1778c9cc-6b73-40ef-a3f8-923fe9eeaba9","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:05:49.749306729Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:05:49.74938+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(102, '{"principal":"admin","path":"/mcp","requestId":"1d610830-3179-4372-ad90-447a9b528b67","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:05:49.802463229Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:05:49.802555+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(103, '{"principal":"admin","path":"/mcp","requestId":"5c93995a-c4cc-41e0-86a4-3bc35449a8ca","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:05:49.856790635Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:05:49.856864+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(104, '{"principal":"admin","path":"/mcp","requestId":"b583228a-c995-4648-87e5-2f8085500d1e","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:05:49.871365967Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:05:49.872251+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(105, '{"principal":"admin","path":"/mcp","requestId":"381be5af-af86-4b56-b948-8d60e48ba0de","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:11:27.457024345Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:11:27.457125+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(106, '{"principal":"admin","path":"/mcp","requestId":"a6ff0c74-060f-4006-a977-c6e4c735e46e","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:11:27.512791093Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:11:27.512974+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(107, '{"principal":"admin","path":"/mcp","requestId":"f55d5782-cb1c-4e94-8d50-9a52347fd81c","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:11:27.567017516Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:11:27.56715+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(108, '{"principal":"admin","path":"/mcp","requestId":"3a143fda-f894-4217-9dc1-cf13ab90be95","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:11:27.578129075Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:11:27.578738+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(109, '{"principal":"admin","path":"/mcp","requestId":"9b2f81e7-9445-423c-8306-3fd7ba47c18a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:14:39.328001143Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:14:39.328102+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(110, '{"principal":"admin","path":"/mcp","requestId":"a2a11ccd-c9c3-4af0-85e1-8c05f05dbc9b","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:14:39.384286427Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:14:39.384434+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(111, '{"principal":"admin","path":"/mcp","requestId":"03d79529-efed-4507-91ec-e8dcf31d5cd7","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:14:39.435632100Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:14:39.435709+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(112, '{"principal":"admin","path":"/mcp","requestId":"d9438c1a-be9c-4d8c-ab56-90af885ae4bf","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:14:39.450306594Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:14:39.451143+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(113, '{"principal":"admin","path":"/mcp","requestId":"1b50cdf5-3c2a-44e0-bee4-9d16005d223c","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:20:44.818587920Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:20:44.818695+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(114, '{"principal":"admin","path":"/mcp","requestId":"3b8c3e2a-5727-4074-9ca0-317bc6a2b998","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:20:44.872539731Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:20:44.872633+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(115, '{"principal":"admin","path":"/mcp","requestId":"9ef2550e-34ee-413c-8c6b-c3df609a4f43","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:20:44.922729877Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:20:44.922788+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(116, '{"principal":"admin","path":"/mcp","requestId":"ec0554ae-8fb4-4c61-ba31-30148dccbd06","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:20:44.932964761Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:20:44.93357+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(117, '{"principal":"admin","path":"/mcp","requestId":"d6a9ce22-6fb1-4f75-aa9f-3fdff60f5b76","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:23:34.465329481Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:23:34.465426+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(118, '{"principal":"admin","path":"/mcp","requestId":"64c84873-bb29-457d-92bc-c4b4886e8473","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:23:34.521867550Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:23:34.522024+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(119, '{"principal":"admin","path":"/mcp","requestId":"c9dc1577-9599-4dd1-9ac7-c40dd9bbeb92","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:23:34.581486626Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:23:34.581589+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(120, '{"principal":"admin","path":"/mcp","requestId":"d5bce66a-adea-479e-8981-57e36db45db2","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:23:34.591703377Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:23:34.592363+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(121, '{"principal":"admin","path":"/mcp","requestId":"759cd35c-4da9-4533-affe-45cb6b4eb66f","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:34:38.087028967Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:34:38.087212+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(122, '{"principal":"admin","path":"/mcp","requestId":"fc04edaa-666c-4d2f-8776-15fc15f0bbc1","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:34:38.138355211Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:34:38.138514+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(123, '{"principal":"admin","path":"/mcp","requestId":"15417909-2b85-43e4-9c09-77c204eea7f3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:34:38.190296525Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:34:38.190418+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(124, '{"principal":"admin","path":"/mcp","requestId":"ec2343cf-923b-4b11-ac63-084c90b836aa","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:34:38.203816350Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:34:38.204705+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(125, '{"principal":"admin","path":"/mcp","requestId":"5bb8c147-2de4-4d0f-8e87-8db03ead8880","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:37:41.224774330Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:37:41.224876+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(126, '{"principal":"admin","path":"/mcp","requestId":"211c9900-21cd-44a7-9141-4195451eb45b","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:37:41.278200530Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:37:41.278396+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(127, '{"principal":"admin","path":"/mcp","requestId":"eecd4c9b-fb0e-41c5-a84d-2744b9e3497d","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T04:37:41.330862805Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:37:41.330972+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(128, '{"principal":"admin","path":"/mcp","requestId":"a9fcc66c-75f6-4fa0-bcee-4ce5b1a3e30a","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T04:37:41.344680870Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 04:37:41.345533+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(129, '{"principal":"admin","path":"/mcp","requestId":"ea6eb611-eb16-4a77-aff6-0d31edd5c506","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:21:04.710025507Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:21:04.710215+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(130, '{"principal":"admin","path":"/mcp","requestId":"33fc80d7-d70b-4221-b6a0-66aa0ae80aab","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T05:21:04.758994905Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:21:04.759144+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(131, '{"principal":"admin","path":"/mcp","requestId":"848ca582-ecc7-4d7e-9f33-15f7a0818fd3","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:21:04.806536744Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:21:04.806599+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(132, '{"principal":"admin","path":"/mcp","requestId":"1ea09d13-ac90-4458-84ba-b43d814266ac","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T05:21:04.814727120Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:21:04.815505+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(133, '{"principal":"admin","path":"/mcp","requestId":"cbd38907-51ce-4601-b006-0717c52b12c6","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:25:10.842391574Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:25:10.842519+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(134, '{"principal":"admin","path":"/mcp","requestId":"960f1c4b-82d4-4a9e-9baa-4bfff95a8a97","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:25:10.891785805Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:25:10.891866+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(135, '{"principal":"admin","path":"/mcp","requestId":"5cd71196-29f2-4930-a7ae-1c7f63b7f036","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:25:10.939917883Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:25:10.939977+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(136, '{"principal":"admin","path":"/mcp","requestId":"7cdc4ed1-f91c-4d16-b38b-dcff68463816","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T05:25:10.947707330Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:25:10.948191+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(137, '{"principal":"admin","path":"/mcp","requestId":"2453cd81-b24d-42d1-a4c9-537ad42a12ca","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:36:56.051611230Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:36:56.051736+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(138, '{"principal":"admin","path":"/mcp","requestId":"1d573d3d-0ff7-4587-9fec-5ba86a6b612f","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:36:56.102685822Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:36:56.102799+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(139, '{"principal":"admin","path":"/mcp","requestId":"3ef38183-f208-4bb1-956e-768174156d56","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":0,"timestamp":"2026-10-31T05:36:56.154258034Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:36:56.154457+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(140, '{"principal":"admin","path":"/mcp","requestId":"76460471-0800-48f2-a323-2da17cfc00eb","clientIp":"172.17.0.1","__origin":"WEB","__ipAddress":"172.17.0.1","httpMethod":"POST","outcome":"success","latencyMs":1,"timestamp":"2026-10-31T05:36:56.164304540Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 05:36:56.165211+00', 'PDF_PROCESS');          
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(161, '{"__apiKeyLabel":"test (sk_20d7d8c9)","errorType":"FileValidationException","__origin":"API","errorMessage":"File cannot be null or empty","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"46fa43a0-9afd-4c00-92d3-994689ace5c9","clientIp":"172.17.0.1","outcome":"failure","latencyMs":16,"timestamp":"2026-10-31T09:58:20.165713860Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 09:58:20.181964+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(162, '{"__apiKeyLabel":"test (sk_20d7d8c9)","errorType":"FileValidationException","__origin":"API","errorMessage":"File cannot be null or empty","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"54de4273-7ef7-4cbd-b8da-082bdb52e314","clientIp":"172.17.0.1","outcome":"failure","latencyMs":1,"timestamp":"2026-10-31T10:01:21.207081388Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:01:21.208603+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(163, '{"__apiKeyLabel":"test (sk_20d7d8c9)","errorType":"FileValidationException","__origin":"API","errorMessage":"File cannot be null or empty","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"20ab859a-7726-4c76-8a77-c1c1a0cb56f0","clientIp":"172.17.0.1","outcome":"failure","latencyMs":1,"timestamp":"2026-10-31T10:03:08.059130241Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:03:08.060318+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(164, '{"__apiKeyLabel":"test (sk_20d7d8c9)","errorType":"FileValidationException","__origin":"API","errorMessage":"File cannot be null or empty","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"85f99950-3447-4a08-b932-b2dd2e8c21fe","clientIp":"172.17.0.1","outcome":"failure","latencyMs":2,"timestamp":"2026-10-31T10:07:14.210906370Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:07:14.212463+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(165, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"38f0d19a-4c0c-4870-82d8-5130f9cdb56b","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":279,"timestamp":"2026-10-31T10:22:20.308621515Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:22:20.587278+00', 'PDF_PROCESS');           
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(166, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"74d70520-91a4-45aa-992d-17de8dd23d07","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":70,"timestamp":"2026-10-31T10:24:02.318848037Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:24:02.388579+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(167, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"5f0b3538-2891-4343-8349-74d52137d8f6","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":78,"timestamp":"2026-10-31T10:25:23.624546805Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:25:23.70244+00', 'PDF_PROCESS');             
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(168, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"05720f9d-3682-444d-9328-3ed553fe6393","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":61,"timestamp":"2026-10-31T10:26:17.909744471Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:26:17.970692+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(169, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"7831253d-6493-47a2-a08f-2dbb52b1ef6a","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":61,"timestamp":"2026-10-31T10:26:44.005776902Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:26:44.066623+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(170, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/misc/compress-pdf","requestId":"1880461d-acb7-4045-bca1-6f082911dd74","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":56,"timestamp":"2026-10-31T10:36:49.497481723Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 10:36:49.553981+00', 'PDF_PROCESS');            
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(193, '{"__apiKeyLabel":"test (sk_20d7d8c9)","formParams":{"optimizeLevel":["5"]},"__origin":"API","__ipAddress":"172.17.0.1","httpMethod":"POST","principal":"admin","path":"/api/v1/storage/files","requestId":"fe6e4b31-76e1-4e7a-8a43-39640f275f17","clientIp":"172.17.0.1","files":[{"size":127362,"name":"sayan_gho.pdf.pdf","type":"application/pdf"}],"outcome":"success","latencyMs":36,"timestamp":"2026-10-31T11:40:41.963176498Z","statusCode":200}', 'admin', 'API', TIMESTAMP WITH TIME ZONE '2026-10-31 11:40:41.999597+00', 'FILE_OPERATION');             
INSERT INTO "PUBLIC"."AUDIT_EVENTS"("ID", "DATA", "PRINCIPAL", "SOURCE", "TIMESTAMP", "TYPE") VALUES(194, '{"policyName":"Classification","formParams":{"fileId":["819e4f38-aac5-41af-be02-fc4e8d6adb54"]},"__origin":"WEB","__ipAddress":"172.17.0.1","sessionId":"node0utm2mikkiyg91k1x199hboz9878","httpMethod":"POST","principal":"admin","path":"/api/v1/policies/6b61d105-a29a-425f-b51c-7cf7f552eeed/run","requestId":"8d2df63e-bc4e-4553-9a66-64bc883eb66f","clientIp":"172.17.0.1","outcome":"success","latencyMs":25,"policySteps":["/api/v1/ai/tools/classify-and-label"],"timestamp":"2026-10-31T11:41:42.201964636Z","statusCode":200}', 'admin', 'WEB', TIMESTAMP WITH TIME ZONE '2026-10-31 11:41:42.227489+00', 'PDF_PROCESS');
CREATE INDEX "PUBLIC"."IDX_AUDIT_TIMESTAMP" ON "PUBLIC"."AUDIT_EVENTS"("TIMESTAMP" NULLS FIRST);               
CREATE INDEX "PUBLIC"."IDX_AUDIT_PRINCIPAL" ON "PUBLIC"."AUDIT_EVENTS"("PRINCIPAL" NULLS FIRST);               
CREATE INDEX "PUBLIC"."IDX_AUDIT_TYPE" ON "PUBLIC"."AUDIT_EVENTS"("TYPE" NULLS FIRST);         
CREATE INDEX "PUBLIC"."IDX_AUDIT_PRINCIPAL_TYPE" ON "PUBLIC"."AUDIT_EVENTS"("PRINCIPAL" NULLS FIRST, "TYPE" NULLS FIRST);      
CREATE INDEX "PUBLIC"."IDX_AUDIT_TYPE_TIMESTAMP" ON "PUBLIC"."AUDIT_EVENTS"("TYPE" NULLS FIRST, "TIMESTAMP" NULLS FIRST);      
CREATE INDEX "PUBLIC"."IDX_AUDIT_TYPE_SOURCE_TIMESTAMP" ON "PUBLIC"."AUDIT_EVENTS"("TYPE" NULLS FIRST, "SOURCE" NULLS FIRST, "TIMESTAMP" NULLS FIRST);         
CREATE INDEX "PUBLIC"."IDX_AUDIT_SOURCE_TIMESTAMP_PRINCIPAL" ON "PUBLIC"."AUDIT_EVENTS"("SOURCE" NULLS FIRST, "TIMESTAMP" NULLS FIRST, "PRINCIPAL" NULLS FIRST);               
CREATE CACHED TABLE "PUBLIC"."AUTHORITIES"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "AUTHORITY" CHARACTER VARYING(255),
    "USER_ID" BIGINT
);           
ALTER TABLE "PUBLIC"."AUTHORITIES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_AB" PRIMARY KEY("ID");  
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.AUTHORITIES;              
INSERT INTO "PUBLIC"."AUTHORITIES"("ID", "AUTHORITY", "USER_ID") VALUES(1, 'ROLE_ADMIN', 1);   
INSERT INTO "PUBLIC"."AUTHORITIES"("ID", "AUTHORITY", "USER_ID") VALUES(2, 'STIRLING-PDF-BACKEND-API-USER', 2);
CREATE INDEX "PUBLIC"."IDX_AUTHORITIES_USER_ID" ON "PUBLIC"."AUTHORITIES"("USER_ID" NULLS FIRST);              
CREATE CACHED TABLE "PUBLIC"."FILE_ENCRYPTION_KEYS"(
    "KEY_ID" UUID NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "KEY_VERSION" INTEGER NOT NULL,
    "MASTER_KEY_VERSION" INTEGER NOT NULL,
    "SCOPE_ID" BIGINT NOT NULL,
    "SCOPE_TYPE" ENUM('GLOBAL', 'SOURCE', 'TEAM') NOT NULL,
    "STATUS" ENUM('ACTIVE', 'DISABLED', 'RETIRED') NOT NULL,
    "STATUS_CHANGED_AT" TIMESTAMP(6),
    "STATUS_CHANGED_BY" CHARACTER VARYING(255),
    "WRAPPED_KEY" CHARACTER VARYING(512) NOT NULL
);    
ALTER TABLE "PUBLIC"."FILE_ENCRYPTION_KEYS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_F" PRIMARY KEY("KEY_ID");      
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILE_ENCRYPTION_KEYS;     
CREATE INDEX "PUBLIC"."IDX_FILE_ENC_KEYS_SCOPE" ON "PUBLIC"."FILE_ENCRYPTION_KEYS"("SCOPE_TYPE" NULLS FIRST, "SCOPE_ID" NULLS FIRST);          
CREATE CACHED TABLE "PUBLIC"."FILE_RUN_EVENTS"(
    "ID" CHARACTER VARYING(255) NOT NULL,
    "ACTOR" CHARACTER VARYING(255),
    "CREATED_AT" TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    "DEDUP_KEY" CHARACTER VARYING(64) NOT NULL,
    "DETAIL" CHARACTER VARYING,
    "FILE_ID" CHARACTER VARYING(255),
    "KIND_ID" CHARACTER VARYING(255) NOT NULL,
    "LAST_SEEN_AT" TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    "OCCURRENCES" INTEGER NOT NULL,
    "ORIGIN" ENUM('PIPELINE', 'POLICY', 'TOOL') NOT NULL,
    "POLICY_ID" CHARACTER VARYING(255),
    "RUN_ID" CHARACTER VARYING(255),
    "SCOPE" ENUM('FILE', 'POLICY', 'RUN', 'SERVER', 'SOURCE') NOT NULL,
    "SEVERITY" ENUM('ERROR', 'INFO', 'WARNING') NOT NULL,
    "SOURCE_ID" CHARACTER VARYING(255),
    "STAGE" ENUM('BLOCKED', 'INPUT', 'INTERNAL', 'NEVER_RAN', 'OUTPUT') NOT NULL,
    "STATUS" ENUM('ACKNOWLEDGED', 'DISMISSED', 'FILE_REMOVED', 'NEW', 'RESOLVED') NOT NULL,
    "STATUS_ACTOR" CHARACTER VARYING(255),
    "STATUS_AT" TIMESTAMP(6) WITH TIME ZONE,
    "TEAM_ID" BIGINT
);          
ALTER TABLE "PUBLIC"."FILE_RUN_EVENTS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_59" PRIMARY KEY("ID");              
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILE_RUN_EVENTS;          
CREATE INDEX "PUBLIC"."IDX_FILE_RUN_EVENTS_TEAM" ON "PUBLIC"."FILE_RUN_EVENTS"("TEAM_ID" NULLS FIRST, "STATUS" NULLS FIRST, "LAST_SEEN_AT" NULLS FIRST);       
CREATE CACHED TABLE "PUBLIC"."FILE_SHARE_ACCESSES"(
    "FILE_SHARE_ACCESS_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "ACCESS_TYPE" ENUM('DOWNLOAD', 'VIEW') NOT NULL,
    "ACCESSED_AT" TIMESTAMP(6) NOT NULL,
    "FILE_SHARE_ID" BIGINT NOT NULL,
    "USER_ID" BIGINT NOT NULL
);             
ALTER TABLE "PUBLIC"."FILE_SHARE_ACCESSES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_E" PRIMARY KEY("FILE_SHARE_ACCESS_ID");         
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILE_SHARE_ACCESSES;      
CREATE INDEX "PUBLIC"."IDX_SHARE_ACCESS_FILE_SHARE" ON "PUBLIC"."FILE_SHARE_ACCESSES"("FILE_SHARE_ID" NULLS FIRST);            
CREATE INDEX "PUBLIC"."IDX_SHARE_ACCESS_USER" ON "PUBLIC"."FILE_SHARE_ACCESSES"("USER_ID" NULLS FIRST);        
CREATE INDEX "PUBLIC"."IDX_SHARE_ACCESS_FILE_SHARE_ACCESSED" ON "PUBLIC"."FILE_SHARE_ACCESSES"("FILE_SHARE_ID" NULLS FIRST, "ACCESSED_AT" NULLS FIRST);        
CREATE CACHED TABLE "PUBLIC"."FILE_SHARES"(
    "FILE_SHARE_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "ACCESS_ROLE" ENUM('COMMENTER', 'EDITOR', 'VIEWER'),
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "EXPIRES_AT" TIMESTAMP(6),
    "PUBLIC_ACCESS" BOOLEAN,
    "SHARE_TOKEN" CHARACTER VARYING(255),
    "STORED_FILE_ID" BIGINT NOT NULL,
    "SHARED_WITH_USER_ID" BIGINT
);               
ALTER TABLE "PUBLIC"."FILE_SHARES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_9" PRIMARY KEY("FILE_SHARE_ID");        
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FILE_SHARES;              
CREATE INDEX "PUBLIC"."IDX_FILE_SHARES_FILE_ID" ON "PUBLIC"."FILE_SHARES"("STORED_FILE_ID" NULLS FIRST);       
CREATE INDEX "PUBLIC"."IDX_FILE_SHARES_SHARE_TOKEN" ON "PUBLIC"."FILE_SHARES"("SHARE_TOKEN" NULLS FIRST);      
CREATE CACHED TABLE "PUBLIC"."FOLDERS"(
    "FOLDER_ID" UUID NOT NULL,
    "COLOR" CHARACTER VARYING(32),
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "ICON" CHARACTER VARYING(64),
    "NAME" CHARACTER VARYING(255) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "VERSION" BIGINT NOT NULL,
    "OWNER_ID" BIGINT NOT NULL,
    "PARENT_FOLDER_ID" UUID
);          
ALTER TABLE "PUBLIC"."FOLDERS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_2" PRIMARY KEY("FOLDER_ID");
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.FOLDERS;  
CREATE INDEX "PUBLIC"."IDX_FOLDERS_OWNER" ON "PUBLIC"."FOLDERS"("OWNER_ID" NULLS FIRST);       
CREATE INDEX "PUBLIC"."IDX_FOLDERS_PARENT" ON "PUBLIC"."FOLDERS"("PARENT_FOLDER_ID" NULLS FIRST);              
CREATE INDEX "PUBLIC"."IDX_FOLDERS_OWNER_PARENT" ON "PUBLIC"."FOLDERS"("OWNER_ID" NULLS FIRST, "PARENT_FOLDER_ID" NULLS FIRST);
CREATE CACHED TABLE "PUBLIC"."INTEGRATION_CONFIGS"(
    "INTEGRATION_CONFIG_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "DEFAULT_ACCESS" ENUM('ADMINS_AND_TEAM_LEADS', 'EXPLICIT_ONLY', 'ORG_ALL') NOT NULL,
    "ENABLED" BOOLEAN NOT NULL,
    "LOCKED" BOOLEAN NOT NULL,
    "SCOPE" ENUM('SERVER', 'TEAM', 'USER') NOT NULL,
    "CONFIG_ENCRYPTED" CHARACTER VARYING,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "INTEGRATION_TYPE" ENUM('API', 'CONSIGNO', 'MCP', 'NETWORK', 'PURVIEW', 'S3', 'VECTOR_DB') NOT NULL,
    "NAME" CHARACTER VARYING(255) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "OWNER_TEAM_ID" BIGINT,
    "OWNER_USER_ID" BIGINT
);          
ALTER TABLE "PUBLIC"."INTEGRATION_CONFIGS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_1D" PRIMARY KEY("INTEGRATION_CONFIG_ID");       
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.INTEGRATION_CONFIGS;      
CREATE INDEX "PUBLIC"."IDX_INTEGRATION_CONFIGS_OWNER" ON "PUBLIC"."INTEGRATION_CONFIGS"("OWNER_USER_ID" NULLS FIRST);          
CREATE INDEX "PUBLIC"."IDX_INTEGRATION_CONFIGS_TYPE" ON "PUBLIC"."INTEGRATION_CONFIGS"("INTEGRATION_TYPE" NULLS FIRST);        
CREATE INDEX "PUBLIC"."IDX_INTEGRATION_CONFIGS_SCOPE" ON "PUBLIC"."INTEGRATION_CONFIGS"("SCOPE" NULLS FIRST);  
CREATE CACHED TABLE "PUBLIC"."INVITE_TOKENS"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "CREATED_BY" CHARACTER VARYING(255) NOT NULL,
    "EMAIL" CHARACTER VARYING(255),
    "EXPIRES_AT" TIMESTAMP(6) NOT NULL,
    "ROLE" CHARACTER VARYING(50) NOT NULL,
    "TEAM_ID" BIGINT,
    "TOKEN" CHARACTER VARYING(100) NOT NULL,
    "USED" BOOLEAN NOT NULL,
    "USED_AT" TIMESTAMP(6)
);          
ALTER TABLE "PUBLIC"."INVITE_TOKENS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_E4" PRIMARY KEY("ID");
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.INVITE_TOKENS;            
CREATE CACHED TABLE "PUBLIC"."JWT_SIGNING_KEYS"(
    "KEY_ID" CHARACTER VARYING(128) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "SIGNING_KEY" CHARACTER VARYING NOT NULL,
    "VERIFYING_KEY" CHARACTER VARYING NOT NULL
);         
ALTER TABLE "PUBLIC"."JWT_SIGNING_KEYS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_7" PRIMARY KEY("KEY_ID");          
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.JWT_SIGNING_KEYS;         
INSERT INTO "PUBLIC"."JWT_SIGNING_KEYS"("KEY_ID", "CREATED_AT", "SIGNING_KEY", "VERIFYING_KEY") VALUES('jwt-key-2026-10-30-091410-e5eca4f2', TIMESTAMP '2026-10-30 09:14:10.014149', 'CwDJOEp0YNOWLV+USvoYjdbpmlsHOhas+RqUcKsxL/BUXzmZxWCB7Uc6Xlfy2IsCfU+L2hGzoMRcpugCxcjDjINwlRPdcwHvuq3aIq2VBgSAIZoyuv9pTyXdNba4fPw5r3I0IHoEJLsye9Pq0a7YK2W7fq4UwY8j4VQ8Ptpb600GGarGmHVu1MnFnPp98wjHknt8T37z57Fdc1Ce9z/RROk8ArVhUUS6bXldT4IXLQPouAv38bCNIt9+qZ8AepMsWznJ7ZNtj4GDVnMDfRuIxF/MLZ4zLgir3soKCN/ISVJIiyBvrfjK4AKfO9GsoZ0aOeDevWBp7lPPtQqN4/4r9+a+Zz19S0A3wqCNxVggQLX/vLIlB2+zNP7e4MQc/ZZzs4+zTLSlefG4LtXVIV1RALHsfEX1zxStcmD5T7zE5lqqFkxItRMldhsZY1lt0ZXXSiVPXzftofKYbY5JLhnfITWmeynLCU30SadlHH2ceYtATJMt77fUBw1usDqFs0Ezy6wmDeGA2q3qQrBBRELRkEv/I5rFA7/fyUQtp2/PHYoV/q2qhvX06MhMEWOq8mg1+5TbqDFm9wurDUW6x+XixHiMeUaGdOh/QdYXjuCOa3a3qC1GuuAfAMNZm1DGTsMt+L4R0d8Q4oviGz0u97BZp9xkILVkFTkJ1p2a0beqMWts5xu879giNHwWh4iOVwfrfyS3f3zCTga0qIdGsiI+kqWe6MiNRGxOVgvp3R6gNh/MoNtNIapog4IvmKUmTjfFM6dynQc/vAEt/vk419EfDuwvaLroPEdrORKvz6dsW+HQ9emPZxARC4gQ5rE9C2TTMRLl1+eYPrcMd2SBl7OsPc8EvvPcPHwp0EnnpqlbJAbXlqBWOIeotjQbxpudgPWPNXQngOhLza/CuhbtIK/L4OVlyIZCMp5CBDSeDUVo20C3n/QWcsKC80AnrwnaqlgpIH+jGObHffHAfW91hWn44QKr552ohiPyhlyQJGrxo1geYsE5ZL0mIrfdVoeTk18wXpEloc9ilVQ1XJfhvDCegM6x41oUbaxgIxOaerdkFNQA758e6In20t77wbmH4+lWdAxuuJfuRgHsJeqfLI9dTKhi5WOVsfWJ8pjQoK7ZOxZ8+Tmdx2ODxbJwk0MvB9YlS09h+3Yze2crEd9rhD7QwlSqRwOtL6KqyoT6hdaFypb8M6cJpvlgtK6Ojb0Wl9FwVtZ16LUOF/sd8+WBwQmJOhsK6TnbERm+YxPBEp7A8F1WY+NnT3jO7Xh1NtCm3+RVJT05KsITQdkTrmJa3W85sDJ4ylaAlTbiSpXvY7AKuEtsrUsMzYZ3p5AEJ+LDPf7/5afpI1QragAVSn8ZWpLkCCXDRp3Z5qNMJuRnojEPzWeMf0AC71V6GjJNoBRGLD56Fx4UJ2I3RfQuhLlw1mW8CcoItYSVpM6afV2THFCk/963KRpUKu6Q8sz7J0jDyStDjWLpO5uNvrQX2T2lGMjiTKy+uyu7dRU2D5QQS06LGAgMi3hDjqq8OQj5+Nns24tX0Dp6Z2mFBJ4yCwqohgl5l3d9TJRSSInvqyRtuBKQzpny+u5YAB2OmxPVrUMxD9naO3MrRIwmPTj/NbFcK9bvc2yGtNWvdA8nOzzq1qIvjTicxvbcPjcp20pVbRtIKnWTYZRhqB3181dvOpuXa00srZUUeZz5d9GVxE4HL82A+CJSJ6sGKuQLdimeP72ZvpF+FEmHUpNRNE1z0kXjzHbJWggzXcSlPqmQSsPMNCx1sX6ozmScBVW2pjQ8E7CmXO0uQuWz1exMQutM9AQuujDHPQV7RB7+oC3kqpyoHFxiMeGjLqWz7pIrxesOaoOxOfax6uLVjRr4vMw09z87mQlrp5+U6igXSOJu3QsG71cOF7Yn8vbYtr2zLhF+nkWkgB8vRGh9OUHdY0HSos8ctadloFkVITQtzcQRLSp1/eSdAXthJpsu1ywaWXG4q1D8jHL177vSbN9HY+D2P5K09isHiZRpegqv76kH1zpOcihrCFKkTdYNu5fPb1cCOQ67uvbFnvmgtEUI7Xw9L1VaCaPXnY/sGBeIwBFAn1O23SDGz+OFawRRqS9LEbNqd2sBzwHwNTNwN8KEDH3OcbVzjNXJ5UWHfBf6OYJHLrYmUIvOCcWX/m8cwMtkqEoUQ7bT+/IB8NLqgDm3HFcwdy88KA4aGGT8wOk=', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0WwCza3oykZEhdkhh7l5mZKGARFLO5pSpLRGUTdVznrKVBDzG8BWE34lm+TrH4LJmnZojXStc+jz7rVSH4yrLtgxfGs8BlNwsGdxCa1Fxs7gLnXEpggLraGJnDV81T011l5HXBaR4NbrK+z4zip3seitqtfzwRnfP+gltDCTejsNBH/dd4xSaVnerO2pWFG25Qsb19GeoTpVvhG4Yh8woPzzTLp1e92mSK8Tv6SUT2mj2W84h8Z6yA7GNmL2oEft8oOwFqtfVRsbcLLxwXz2/HEdqZaUl1i8M13xA4F+0pLZ1LYg7AeqRKrI17lo55lrwVmVA0wypOwiqCBa/Y9EBQIDAQAB');              
CREATE CACHED TABLE "PUBLIC"."ORG_OWNER"(
    "ID" BIGINT NOT NULL,
    "ASSIGNED_AT" TIMESTAMP(6),
    "ASSIGNED_REASON" CHARACTER VARYING(255),
    "HANDOVER_CLOUD_EMAIL" CHARACTER VARYING(255),
    "HANDOVER_CLOUD_USER_ID" BIGINT,
    "HANDOVER_DEVICE_ID" CHARACTER VARYING(255),
    "HANDOVER_LEADER_ID" BIGINT,
    "HANDOVER_TARGET_EMAIL" CHARACTER VARYING(255),
    "HANDOVER_TARGET_ID" BIGINT,
    "HANDOVER_TARGET_USERNAME" CHARACTER VARYING(255),
    "HANDOVER_TEAM_ID" BIGINT,
    "OWNER_USER_ID" BIGINT,
    "OWNER_USERNAME" CHARACTER VARYING(255)
);              
ALTER TABLE "PUBLIC"."ORG_OWNER" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_59B" PRIMARY KEY("ID");   
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.ORG_OWNER;
INSERT INTO "PUBLIC"."ORG_OWNER"("ID", "ASSIGNED_AT", "ASSIGNED_REASON", "HANDOVER_CLOUD_EMAIL", "HANDOVER_CLOUD_USER_ID", "HANDOVER_DEVICE_ID", "HANDOVER_LEADER_ID", "HANDOVER_TARGET_EMAIL", "HANDOVER_TARGET_ID", "HANDOVER_TARGET_USERNAME", "HANDOVER_TEAM_ID", "OWNER_USER_ID", "OWNER_USERNAME") VALUES(1, TIMESTAMP '2026-10-30 09:14:13.545257', 'RECONCILE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'admin');           
CREATE CACHED TABLE "PUBLIC"."PARTICIPANT_NOTIFICATIONS"(
    "PARTICIPANT_ID" BIGINT NOT NULL,
    "NOTIFICATION_MESSAGE" CHARACTER VARYING
);
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.PARTICIPANT_NOTIFICATIONS;
CREATE CACHED TABLE "PUBLIC"."PERSISTENT_LOGINS"(
    "SERIES" CHARACTER VARYING(255) NOT NULL,
    "LAST_USED" TIMESTAMP(6) WITH TIME ZONE NOT NULL,
    "TOKEN" CHARACTER VARYING(64) NOT NULL,
    "USERNAME" CHARACTER VARYING(64) NOT NULL
);             
ALTER TABLE "PUBLIC"."PERSISTENT_LOGINS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_A3" PRIMARY KEY("SERIES");        
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.PERSISTENT_LOGINS;        
CREATE CACHED TABLE "PUBLIC"."POLICIES"(
    "ID" CHARACTER VARYING(255) NOT NULL,
    "ENABLED" BOOLEAN,
    "NAME" CHARACTER VARYING(255),
    "OWNER" CHARACTER VARYING(255),
    "POLICY_JSON" CHARACTER VARYING,
    "SORT_ORDER" INTEGER,
    "TEAM_ID" BIGINT
);        
ALTER TABLE "PUBLIC"."POLICIES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_4" PRIMARY KEY("ID");      
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.POLICIES; 
INSERT INTO "PUBLIC"."POLICIES"("ID", "ENABLED", "NAME", "OWNER", "POLICY_JSON", "SORT_ORDER", "TEAM_ID") VALUES('6b61d105-a29a-425f-b51c-7cf7f552eeed', TRUE, 'Classification', NULL, '{"id":"6b61d105-a29a-425f-b51c-7cf7f552eeed","name":"Classification","owner":null,"enabled":true,"required":false,"icon":"","inputs":[],"steps":[{"operation":"/api/v1/ai/tools/classify-and-label","parameters":{},"fileParameters":{}}],"output":{"type":"inline","options":{"mode":"new_version","sources":[],"reviewerEmail":"","scopeTypes":[],"categoryId":"classification"}},"outputIds":[],"teamId":1,"editor":{"allowed":true,"runOn":"upload"},"surface":"policy","routingRules":[]}', 0, 1);
CREATE CACHED TABLE "PUBLIC"."POLICY_ASSETS"(
    "ID" CHARACTER VARYING(255) NOT NULL,
    "CONTENT_TYPE" CHARACTER VARYING(255),
    "CREATED_AT" BIGINT,
    "DATA" BINARY VARYING NOT NULL,
    "FILE_NAME" CHARACTER VARYING(255),
    "FILE_SIZE" BIGINT,
    "OWNER" CHARACTER VARYING(255),
    "TEAM_ID" BIGINT
);    
ALTER TABLE "PUBLIC"."POLICY_ASSETS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_C5" PRIMARY KEY("ID");
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_ASSETS;            
CREATE CACHED TABLE "PUBLIC"."POLICY_COMPLETED_MIGRATIONS"(
    "ID" CHARACTER VARYING(255) NOT NULL,
    "APPLIED_AT" TIMESTAMP(6) WITH TIME ZONE
);          
ALTER TABLE "PUBLIC"."POLICY_COMPLETED_MIGRATIONS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_B6" PRIMARY KEY("ID");  
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_COMPLETED_MIGRATIONS;              
INSERT INTO "PUBLIC"."POLICY_COMPLETED_MIGRATIONS"("ID", "APPLIED_AT") VALUES('embedded-s3-credentials', TIMESTAMP WITH TIME ZONE '2026-10-30 09:14:15.216216+00');            
INSERT INTO "PUBLIC"."POLICY_COMPLETED_MIGRATIONS"("ID", "APPLIED_AT") VALUES('policy-inline-output', TIMESTAMP WITH TIME ZONE '2026-10-30 09:14:15.220107+00');               
CREATE CACHED TABLE "PUBLIC"."POLICY_PROCESSED_FILES"(
    "IDENTITY_HASH" CHARACTER VARYING(64) NOT NULL,
    "POLICY_ID" CHARACTER VARYING(255) NOT NULL,
    "ATTEMPTS" INTEGER,
    "CONTENT_HASH" CHARACTER VARYING(64),
    "IDENTITY" CHARACTER VARYING(4096),
    "LAST_SEEN" BIGINT,
    "SIGNATURE" CHARACTER VARYING(255),
    "STATUS" ENUM('DONE', 'ERROR', 'INTERRUPTED', 'PROCESSING'),
    "UPDATED_AT" BIGINT
);              
ALTER TABLE "PUBLIC"."POLICY_PROCESSED_FILES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_AF" PRIMARY KEY("IDENTITY_HASH", "POLICY_ID");               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_PROCESSED_FILES;   
CREATE INDEX "PUBLIC"."IDX_PROCESSED_FILES_POLICY_SEEN" ON "PUBLIC"."POLICY_PROCESSED_FILES"("POLICY_ID" NULLS FIRST, "LAST_SEEN" NULLS FIRST);
CREATE INDEX "PUBLIC"."IDX_PROCESSED_FILES_IDENTITY" ON "PUBLIC"."POLICY_PROCESSED_FILES"("IDENTITY_HASH" NULLS FIRST);        
CREATE CACHED TABLE "PUBLIC"."POLICY_SOURCE_DOC_COUNTS"(
    "BUCKET_HOUR" BIGINT NOT NULL,
    "SOURCE_ID" CHARACTER VARYING(255) NOT NULL,
    "DOC_COUNT" BIGINT
);         
ALTER TABLE "PUBLIC"."POLICY_SOURCE_DOC_COUNTS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_D" PRIMARY KEY("BUCKET_HOUR", "SOURCE_ID");
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_SOURCE_DOC_COUNTS; 
INSERT INTO "PUBLIC"."POLICY_SOURCE_DOC_COUNTS"("BUCKET_HOUR", "SOURCE_ID", "DOC_COUNT") VALUES(498179, 'editor:1', 1);        
CREATE CACHED TABLE "PUBLIC"."POLICY_SOURCE_DOC_TOTALS"(
    "SOURCE_ID" CHARACTER VARYING(255) NOT NULL,
    "DOC_TOTAL" BIGINT
);            
ALTER TABLE "PUBLIC"."POLICY_SOURCE_DOC_TOTALS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_FA" PRIMARY KEY("SOURCE_ID");              
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_SOURCE_DOC_TOTALS; 
INSERT INTO "PUBLIC"."POLICY_SOURCE_DOC_TOTALS"("SOURCE_ID", "DOC_TOTAL") VALUES('editor:1', 1);               
CREATE CACHED TABLE "PUBLIC"."POLICY_SOURCES"(
    "ID" CHARACTER VARYING(255) NOT NULL,
    "ENABLED" BOOLEAN,
    "NAME" CHARACTER VARYING(255),
    "OWNER" CHARACTER VARYING(255),
    "SOURCE_JSON" CHARACTER VARYING,
    "TEAM_ID" BIGINT,
    "TYPE" CHARACTER VARYING(255)
);         
ALTER TABLE "PUBLIC"."POLICY_SOURCES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_A7" PRIMARY KEY("ID");               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.POLICY_SOURCES;           
CREATE CACHED TABLE "PUBLIC"."RESOURCE_GRANTS"(
    "RESOURCE_GRANT_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "PERMISSION" ENUM('MANAGE', 'USE') NOT NULL,
    "PRINCIPAL_ID" BIGINT NOT NULL,
    "PRINCIPAL_TYPE" ENUM('TEAM', 'USER') NOT NULL,
    "RESOURCE_ID" CHARACTER VARYING(255) NOT NULL,
    "RESOURCE_TYPE" ENUM('INTEGRATION_CONFIG', 'PORTAL') NOT NULL,
    "GRANTED_BY_USER_ID" BIGINT
);              
ALTER TABLE "PUBLIC"."RESOURCE_GRANTS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_F9" PRIMARY KEY("RESOURCE_GRANT_ID");               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.RESOURCE_GRANTS;          
CREATE INDEX "PUBLIC"."IDX_RESOURCE_GRANTS_LOOKUP" ON "PUBLIC"."RESOURCE_GRANTS"("RESOURCE_TYPE" NULLS FIRST, "RESOURCE_ID" NULLS FIRST);      
CREATE INDEX "PUBLIC"."IDX_RESOURCE_GRANTS_PRINCIPAL" ON "PUBLIC"."RESOURCE_GRANTS"("PRINCIPAL_TYPE" NULLS FIRST, "PRINCIPAL_ID" NULLS FIRST); 
CREATE CACHED TABLE "PUBLIC"."SESSIONS"(
    "SESSION_ID" CHARACTER VARYING(255) NOT NULL,
    "EXPIRED" BOOLEAN NOT NULL,
    "LAST_REQUEST" TIMESTAMP(6) WITH TIME ZONE,
    "PRINCIPAL_NAME" CHARACTER VARYING(255)
);      
ALTER TABLE "PUBLIC"."SESSIONS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_8" PRIMARY KEY("SESSION_ID");              
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.SESSIONS; 
CREATE INDEX "PUBLIC"."IDX_SESSIONS_PRINCIPAL_LAST" ON "PUBLIC"."SESSIONS"("PRINCIPAL_NAME" NULLS FIRST, "LAST_REQUEST" NULLS FIRST);          
CREATE INDEX "PUBLIC"."IDX_SESSIONS_EXPIRED" ON "PUBLIC"."SESSIONS"("EXPIRED" NULLS FIRST);    
CREATE CACHED TABLE "PUBLIC"."STORAGE_CLEANUP_ENTRIES"(
    "CLEANUP_ENTRY_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "ATTEMPT_COUNT" INTEGER,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "STORAGE_KEY" CHARACTER VARYING(128) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL
);               
ALTER TABLE "PUBLIC"."STORAGE_CLEANUP_ENTRIES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_6E" PRIMARY KEY("CLEANUP_ENTRY_ID");        
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.STORAGE_CLEANUP_ENTRIES;  
CREATE CACHED TABLE "PUBLIC"."STORED_FILE_BLOBS"(
    "STORAGE_KEY" CHARACTER VARYING(128) NOT NULL,
    "DATA" BINARY VARYING NOT NULL
);     
ALTER TABLE "PUBLIC"."STORED_FILE_BLOBS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_A6" PRIMARY KEY("STORAGE_KEY");   
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.STORED_FILE_BLOBS;        
CREATE CACHED TABLE "PUBLIC"."STORED_FILES"(
    "STORED_FILE_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 2) NOT NULL,
    "AUDIT_LOG_CONTENT_TYPE" CHARACTER VARYING(255),
    "AUDIT_LOG_FILENAME" CHARACTER VARYING(255),
    "AUDIT_LOG_SIZE_BYTES" BIGINT,
    "AUDIT_LOG_STORAGE_KEY" CHARACTER VARYING(255),
    "CONTENT_TYPE" CHARACTER VARYING(255),
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "ENCRYPTION_KEY_ID" CHARACTER VARYING(36),
    "EXPIRES_AT" TIMESTAMP(6),
    "HISTORY_CONTENT_TYPE" CHARACTER VARYING(255),
    "HISTORY_FILENAME" CHARACTER VARYING(255),
    "HISTORY_SIZE_BYTES" BIGINT,
    "HISTORY_STORAGE_KEY" CHARACTER VARYING(255),
    "ORIGINAL_FILENAME" CHARACTER VARYING(255) NOT NULL,
    "FILE_PURPOSE" ENUM('GENERIC', 'SIGNING_HISTORY', 'SIGNING_ORIGINAL', 'SIGNING_SIGNED'),
    "SIZE_BYTES" BIGINT,
    "STORAGE_KEY" CHARACTER VARYING(255) NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "FOLDER_ID" UUID,
    "OWNER_ID" BIGINT NOT NULL,
    "WORKFLOW_SESSION_ID" BIGINT
);        
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_ED" PRIMARY KEY("STORED_FILE_ID");     
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.STORED_FILES;             
INSERT INTO "PUBLIC"."STORED_FILES"("STORED_FILE_ID", "AUDIT_LOG_CONTENT_TYPE", "AUDIT_LOG_FILENAME", "AUDIT_LOG_SIZE_BYTES", "AUDIT_LOG_STORAGE_KEY", "CONTENT_TYPE", "CREATED_AT", "ENCRYPTION_KEY_ID", "EXPIRES_AT", "HISTORY_CONTENT_TYPE", "HISTORY_FILENAME", "HISTORY_SIZE_BYTES", "HISTORY_STORAGE_KEY", "ORIGINAL_FILENAME", "FILE_PURPOSE", "SIZE_BYTES", "STORAGE_KEY", "UPDATED_AT", "FOLDER_ID", "OWNER_ID", "WORKFLOW_SESSION_ID") VALUES(1, NULL, NULL, NULL, NULL, 'application/pdf', TIMESTAMP '2026-10-31 11:40:41.975012', NULL, NULL, NULL, NULL, NULL, NULL, 'sayan_gho.pdf.pdf', NULL, 127362, '1/fb7998ed-93b6-45ab-b58b-7a19968133f4_sayan_gho.pdf.pdf', TIMESTAMP '2026-10-31 11:40:41.975048', NULL, 1, NULL);       
CREATE INDEX "PUBLIC"."IDX_STORED_FILES_OWNER" ON "PUBLIC"."STORED_FILES"("OWNER_ID" NULLS FIRST);             
CREATE INDEX "PUBLIC"."IDX_STORED_FILES_WORKFLOW" ON "PUBLIC"."STORED_FILES"("WORKFLOW_SESSION_ID" NULLS FIRST);               
CREATE INDEX "PUBLIC"."IDX_STORED_FILES_FOLDER" ON "PUBLIC"."STORED_FILES"("FOLDER_ID" NULLS FIRST);           
CREATE CACHED TABLE "PUBLIC"."TEAM_MEMBERSHIPS"(
    "MEMBERSHIP_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "ACCEPTED_AT" TIMESTAMP(6),
    "CAP_UNITS" BIGINT,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "INVITED_AT" TIMESTAMP(6) NOT NULL,
    "ROLE" ENUM('LEADER', 'MEMBER') NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "INVITED_BY_USER_ID" BIGINT,
    "TEAM_ID" BIGINT NOT NULL,
    "USER_ID" BIGINT NOT NULL
);            
ALTER TABLE "PUBLIC"."TEAM_MEMBERSHIPS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_18" PRIMARY KEY("MEMBERSHIP_ID");  
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.TEAM_MEMBERSHIPS;         
INSERT INTO "PUBLIC"."TEAM_MEMBERSHIPS"("MEMBERSHIP_ID", "ACCEPTED_AT", "CAP_UNITS", "CREATED_AT", "INVITED_AT", "ROLE", "UPDATED_AT", "INVITED_BY_USER_ID", "TEAM_ID", "USER_ID") VALUES(1, TIMESTAMP '2026-10-30 09:14:13.522617', NULL, TIMESTAMP '2026-10-30 09:14:13.522998', TIMESTAMP '2026-10-30 09:14:13.522606', 'MEMBER', TIMESTAMP '2026-10-30 09:14:13.523007', NULL, 1, 1);      
INSERT INTO "PUBLIC"."TEAM_MEMBERSHIPS"("MEMBERSHIP_ID", "ACCEPTED_AT", "CAP_UNITS", "CREATED_AT", "INVITED_AT", "ROLE", "UPDATED_AT", "INVITED_BY_USER_ID", "TEAM_ID", "USER_ID") VALUES(2, TIMESTAMP '2026-10-30 09:14:13.734314', NULL, TIMESTAMP '2026-10-30 09:14:13.734481', TIMESTAMP '2026-10-30 09:14:13.734308', 'MEMBER', TIMESTAMP '2026-10-30 09:14:13.734489', NULL, 2, 2);      
CREATE INDEX "PUBLIC"."IDX_TEAM_MEMBERSHIPS_USER_ROLE" ON "PUBLIC"."TEAM_MEMBERSHIPS"("USER_ID" NULLS FIRST, "ROLE" NULLS FIRST);              
CREATE INDEX "PUBLIC"."IDX_TEAM_MEMBERSHIPS_TEAM_ROLE" ON "PUBLIC"."TEAM_MEMBERSHIPS"("TEAM_ID" NULLS FIRST, "ROLE" NULLS FIRST);              
CREATE CACHED TABLE "PUBLIC"."TEAMS"(
    "TEAM_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "NAME" CHARACTER VARYING(255) NOT NULL
);              
ALTER TABLE "PUBLIC"."TEAMS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_4C" PRIMARY KEY("TEAM_ID");   
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.TEAMS;    
INSERT INTO "PUBLIC"."TEAMS"("TEAM_ID", "NAME") VALUES(1, 'Default');          
INSERT INTO "PUBLIC"."TEAMS"("TEAM_ID", "NAME") VALUES(2, 'Internal');         
CREATE CACHED TABLE "PUBLIC"."TOOL_CHAIN_STATS"(
    "CHAIN_KEY" CHARACTER VARYING(520) NOT NULL,
    "EPOCH_DAY" BIGINT NOT NULL,
    "PRINCIPAL" CHARACTER VARYING(255) NOT NULL,
    "CHAIN_LENGTH" INTEGER,
    "COUNT" BIGINT
);          
ALTER TABLE "PUBLIC"."TOOL_CHAIN_STATS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_D1" PRIMARY KEY("CHAIN_KEY", "EPOCH_DAY", "PRINCIPAL");            
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.TOOL_CHAIN_STATS;         
CREATE INDEX "PUBLIC"."IDX_TOOL_CHAIN_DAY" ON "PUBLIC"."TOOL_CHAIN_STATS"("EPOCH_DAY" NULLS FIRST);            
CREATE INDEX "PUBLIC"."IDX_TOOL_CHAIN_PRINCIPAL_DAY" ON "PUBLIC"."TOOL_CHAIN_STATS"("PRINCIPAL" NULLS FIRST, "EPOCH_DAY" NULLS FIRST);         
CREATE INDEX "PUBLIC"."IDX_TOOL_CHAIN_LENGTH_DAY" ON "PUBLIC"."TOOL_CHAIN_STATS"("CHAIN_LENGTH" NULLS FIRST, "EPOCH_DAY" NULLS FIRST);         
CREATE CACHED TABLE "PUBLIC"."TOOL_USAGE_STATS"(
    "EPOCH_DAY" BIGINT NOT NULL,
    "FROM_TOOL" CHARACTER VARYING(64) NOT NULL,
    "PRINCIPAL" CHARACTER VARYING(255) NOT NULL,
    "TOOL_KEY" CHARACTER VARYING(64) NOT NULL,
    "COUNT" BIGINT
);        
ALTER TABLE "PUBLIC"."TOOL_USAGE_STATS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_1D4" PRIMARY KEY("EPOCH_DAY", "FROM_TOOL", "PRINCIPAL", "TOOL_KEY");               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.TOOL_USAGE_STATS;         
CREATE INDEX "PUBLIC"."IDX_TOOL_USAGE_DAY" ON "PUBLIC"."TOOL_USAGE_STATS"("EPOCH_DAY" NULLS FIRST);            
CREATE INDEX "PUBLIC"."IDX_TOOL_USAGE_PRINCIPAL_DAY" ON "PUBLIC"."TOOL_USAGE_STATS"("PRINCIPAL" NULLS FIRST, "EPOCH_DAY" NULLS FIRST);         
CREATE INDEX "PUBLIC"."IDX_TOOL_USAGE_FROM_DAY" ON "PUBLIC"."TOOL_USAGE_STATS"("FROM_TOOL" NULLS FIRST, "EPOCH_DAY" NULLS FIRST);              
CREATE CACHED TABLE "PUBLIC"."USER_LICENSE_SETTINGS"(
    "ID" BIGINT NOT NULL,
    "GRANDFATHERED_USER_COUNT" INTEGER NOT NULL,
    "GRANDFATHERED_USER_SIGNATURE" CHARACTER VARYING(256) NOT NULL,
    "GRANDFATHERING_LOCKED" BOOLEAN NOT NULL,
    "INTEGRITY_SALT" CHARACTER VARYING(64) NOT NULL,
    "LICENSE_MAX_USERS" INTEGER NOT NULL,
    "LINKED_TEAM_DEVICE_ID" CHARACTER VARYING(255),
    "LINKED_TEAM_USERS" INTEGER
);       
ALTER TABLE "PUBLIC"."USER_LICENSE_SETTINGS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_99" PRIMARY KEY("ID");        
-- 1 +/- SELECT COUNT(*) FROM PUBLIC.USER_LICENSE_SETTINGS;    
INSERT INTO "PUBLIC"."USER_LICENSE_SETTINGS"("ID", "GRANDFATHERED_USER_COUNT", "GRANDFATHERED_USER_SIGNATURE", "GRANDFATHERING_LOCKED", "INTEGRITY_SALT", "LICENSE_MAX_USERS", "LINKED_TEAM_DEVICE_ID", "LINKED_TEAM_USERS") VALUES(1, 5, '5:obJGT3obr7GaEUoGk_0mqrWlYVO8xspdKLeKt14_9F4', TRUE, '36dd5834-aaac-4c0a-aec6-59475b716ebc', 0, NULL, NULL);       
CREATE CACHED TABLE "PUBLIC"."USER_SERVER_CERTIFICATES"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CERTIFICATE_TYPE" ENUM('AUTO_GENERATED', 'USER_UPLOADED') NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "ISSUER_DN" CHARACTER VARYING(500),
    "KEYSTORE_DATA" BINARY VARYING NOT NULL,
    "KEYSTORE_PASSWORD" CHARACTER VARYING(255) NOT NULL,
    "SUBJECT_DN" CHARACTER VARYING(500),
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "VALID_FROM" TIMESTAMP(6),
    "VALID_TO" TIMESTAMP(6),
    "USER_ID" BIGINT NOT NULL
); 
ALTER TABLE "PUBLIC"."USER_SERVER_CERTIFICATES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_F7" PRIMARY KEY("ID");     
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.USER_SERVER_CERTIFICATES; 
CREATE CACHED TABLE "PUBLIC"."USER_SETTINGS"(
    "USER_ID" BIGINT NOT NULL,
    "SETTING_VALUE" CHARACTER VARYING,
    "SETTING_KEY" CHARACTER VARYING(255) NOT NULL
);       
ALTER TABLE "PUBLIC"."USER_SETTINGS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_9A" PRIMARY KEY("USER_ID", "SETTING_KEY");            
-- 4 +/- SELECT COUNT(*) FROM PUBLIC.USER_SETTINGS;            
INSERT INTO "PUBLIC"."USER_SETTINGS"("USER_ID", "SETTING_VALUE", "SETTING_KEY") VALUES(1, 'false', 'mfaEnabled');              
INSERT INTO "PUBLIC"."USER_SETTINGS"("USER_ID", "SETTING_VALUE", "SETTING_KEY") VALUES(1, 'false', 'mfaRequired');             
INSERT INTO "PUBLIC"."USER_SETTINGS"("USER_ID", "SETTING_VALUE", "SETTING_KEY") VALUES(2, 'false', 'mfaEnabled');              
INSERT INTO "PUBLIC"."USER_SETTINGS"("USER_ID", "SETTING_VALUE", "SETTING_KEY") VALUES(2, 'false', 'mfaRequired');             
CREATE CACHED TABLE "PUBLIC"."USERS"(
    "USER_ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1 RESTART WITH 33) NOT NULL,
    "API_KEY" CHARACTER VARYING(255),
    "AUTHENTICATIONTYPE" CHARACTER VARYING(255),
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "EMAIL" CHARACTER VARYING(255),
    "ENABLED" BOOLEAN,
    "FORCE_PASSWORD_CHANGE" BOOLEAN,
    "HAS_COMPLETED_INITIAL_SETUP" BOOLEAN,
    "IS_FIRST_LOGIN" BOOLEAN,
    "OAUTH_GRANDFATHERED" BOOLEAN,
    "PASSWORD" CHARACTER VARYING(255),
    "ROLE_NAME" CHARACTER VARYING(255),
    "SSO_PROVIDER" CHARACTER VARYING(255),
    "SSO_PROVIDER_ID" CHARACTER VARYING(255),
    "SUPABASE_AUTH_ID" UUID,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "USERNAME" CHARACTER VARYING(255),
    "TEAM_ID" BIGINT
);     
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_4D" PRIMARY KEY("USER_ID");   
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.USERS;    
INSERT INTO "PUBLIC"."USERS"("USER_ID", "API_KEY", "AUTHENTICATIONTYPE", "CREATED_AT", "EMAIL", "ENABLED", "FORCE_PASSWORD_CHANGE", "HAS_COMPLETED_INITIAL_SETUP", "IS_FIRST_LOGIN", "OAUTH_GRANDFATHERED", "PASSWORD", "ROLE_NAME", "SSO_PROVIDER", "SSO_PROVIDER_ID", "SUPABASE_AUTH_ID", "UPDATED_AT", "USERNAME", "TEAM_ID") VALUES(1, '2ac78081-787a-490d-adc4-9d5dba15f2c4', 'web', TIMESTAMP '2026-10-30 09:14:13.50864', NULL, TRUE, FALSE, FALSE, FALSE, FALSE, '$2a$10$.KkEgaeXkiNkaciOO/B6GuGi6YJNfd0QZbbgLrrr.cun/iKDOrO.q', NULL, NULL, NULL, NULL, TIMESTAMP '2026-10-31 11:41:42.226017', 'admin', 1);          
INSERT INTO "PUBLIC"."USERS"("USER_ID", "API_KEY", "AUTHENTICATIONTYPE", "CREATED_AT", "EMAIL", "ENABLED", "FORCE_PASSWORD_CHANGE", "HAS_COMPLETED_INITIAL_SETUP", "IS_FIRST_LOGIN", "OAUTH_GRANDFATHERED", "PASSWORD", "ROLE_NAME", "SSO_PROVIDER", "SSO_PROVIDER_ID", "SUPABASE_AUTH_ID", "UPDATED_AT", "USERNAME", "TEAM_ID") VALUES(2, '70151711-d401-43bb-bfbb-db67d6b5be66', 'web', TIMESTAMP '2026-10-30 09:14:13.730911', NULL, TRUE, FALSE, FALSE, FALSE, FALSE, '$2a$10$JhUc5Dd95u6PfmC.eB6MKOiJJrxWRJVv.i0yl8Qm2ad/1yVb1ITQK', NULL, NULL, NULL, NULL, TIMESTAMP '2026-10-30 09:14:13.799414', 'STIRLING-PDF-BACKEND-API-USER', 2); 
CREATE INDEX "PUBLIC"."IDX_USERS_TEAM_ID" ON "PUBLIC"."USERS"("TEAM_ID" NULLS FIRST);          
CREATE CACHED TABLE "PUBLIC"."WORKFLOW_PARTICIPANTS"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "ACCESS_ROLE" ENUM('COMMENTER', 'EDITOR', 'VIEWER') NOT NULL,
    "EMAIL" CHARACTER VARYING(255),
    "EXPIRES_AT" TIMESTAMP(6),
    "LAST_UPDATED" TIMESTAMP(6) NOT NULL,
    "NAME" CHARACTER VARYING(255),
    "PARTICIPANT_METADATA" JSON,
    "SHARE_TOKEN" CHARACTER VARYING(36),
    "STATUS" ENUM('DECLINED', 'NOTIFIED', 'PENDING', 'SIGNED', 'VIEWED') NOT NULL,
    "USER_ID" BIGINT,
    "WORKFLOW_SESSION_ID" BIGINT NOT NULL
);               
ALTER TABLE "PUBLIC"."WORKFLOW_PARTICIPANTS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_53" PRIMARY KEY("ID");        
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.WORKFLOW_PARTICIPANTS;    
CREATE INDEX "PUBLIC"."IDX_WORKFLOW_PARTICIPANTS_SESSION" ON "PUBLIC"."WORKFLOW_PARTICIPANTS"("WORKFLOW_SESSION_ID" NULLS FIRST);              
CREATE INDEX "PUBLIC"."IDX_WORKFLOW_PARTICIPANTS_TOKEN" ON "PUBLIC"."WORKFLOW_PARTICIPANTS"("SHARE_TOKEN" NULLS FIRST);        
CREATE INDEX "PUBLIC"."IDX_WORKFLOW_PARTICIPANTS_USER" ON "PUBLIC"."WORKFLOW_PARTICIPANTS"("USER_ID" NULLS FIRST);             
CREATE CACHED TABLE "PUBLIC"."WORKFLOW_SESSIONS"(
    "ID" BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL,
    "CREATED_AT" TIMESTAMP(6) NOT NULL,
    "DOCUMENT_NAME" CHARACTER VARYING(255) NOT NULL,
    "DUE_DATE" CHARACTER VARYING(50),
    "FINALIZED" BOOLEAN NOT NULL,
    "MESSAGE" CHARACTER VARYING,
    "OWNER_EMAIL" CHARACTER VARYING(255),
    "SESSION_ID" CHARACTER VARYING(36) NOT NULL,
    "STATUS" ENUM('CANCELLED', 'COMPLETED', 'IN_PROGRESS') NOT NULL,
    "UPDATED_AT" TIMESTAMP(6) NOT NULL,
    "WORKFLOW_METADATA" JSON,
    "WORKFLOW_TYPE" ENUM('APPROVAL', 'REVIEW', 'SIGNING') NOT NULL,
    "ORIGINAL_FILE_ID" BIGINT NOT NULL,
    "OWNER_ID" BIGINT NOT NULL,
    "PROCESSED_FILE_ID" BIGINT
);           
ALTER TABLE "PUBLIC"."WORKFLOW_SESSIONS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_F9E" PRIMARY KEY("ID");           
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.WORKFLOW_SESSIONS;        
CREATE INDEX "PUBLIC"."IDX_WORKFLOW_SESSIONS_OWNER" ON "PUBLIC"."WORKFLOW_SESSIONS"("OWNER_ID" NULLS FIRST);   
CREATE INDEX "PUBLIC"."IDX_WORKFLOW_SESSIONS_SESSION_ID" ON "PUBLIC"."WORKFLOW_SESSIONS"("SESSION_ID" NULLS FIRST);            
ALTER TABLE "PUBLIC"."FILE_SHARES" ADD CONSTRAINT "PUBLIC"."UK_FILE_SHARE_TOKEN" UNIQUE NULLS DISTINCT ("SHARE_TOKEN");        
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."UKKIBF2VKT94IJJ8XO1MROWQ5L1" UNIQUE NULLS DISTINCT ("HISTORY_STORAGE_KEY");       
ALTER TABLE "PUBLIC"."WORKFLOW_SESSIONS" ADD CONSTRAINT "PUBLIC"."UK81N77BHQ6QYDL6Y636SE8D48" UNIQUE NULLS DISTINCT ("SESSION_ID");            
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."UK9ULA6R3GIXG4M998BTCK9CG57" UNIQUE NULLS DISTINCT ("AUDIT_LOG_STORAGE_KEY");     
ALTER TABLE "PUBLIC"."FILE_ENCRYPTION_KEYS" ADD CONSTRAINT "PUBLIC"."UK_FILE_ENC_KEYS_SCOPE_VERSION" UNIQUE NULLS DISTINCT ("SCOPE_TYPE", "SCOPE_ID", "KEY_VERSION");          
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."UKR43AF9AP4EDM43MMTQ01ODDJ6" UNIQUE NULLS DISTINCT ("USERNAME");         
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."UKD10RFXXO1EBTY2NKPKF4D2ORP" UNIQUE NULLS DISTINCT ("STORAGE_KEY");               
ALTER TABLE "PUBLIC"."FILE_SHARES" ADD CONSTRAINT "PUBLIC"."UK_FILE_SHARE_USER" UNIQUE NULLS DISTINCT ("STORED_FILE_ID", "SHARED_WITH_USER_ID");               
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_METERED_SIGNATURE" ADD CONSTRAINT "PUBLIC"."UK_ACCOUNT_LINK_METERED_SIGNATURE" UNIQUE NULLS DISTINCT ("PERIOD_START", "SIGNATURE");         
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."UK9EOIKAGWA2GQN4V9KOVY4R61S" UNIQUE NULLS DISTINCT ("SUPABASE_AUTH_ID"); 
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."UK6DOTKOTT2KJSP8VW4D0M25FB7" UNIQUE NULLS DISTINCT ("EMAIL");            
ALTER TABLE "PUBLIC"."WORKFLOW_PARTICIPANTS" ADD CONSTRAINT "PUBLIC"."UK8HF5RE9PKQL5MILP5Q63YJXMI" UNIQUE NULLS DISTINCT ("SHARE_TOKEN");      
ALTER TABLE "PUBLIC"."INVITE_TOKENS" ADD CONSTRAINT "PUBLIC"."UKEWCI50C0NCFIIHR2TC41NFBNF" UNIQUE NULLS DISTINCT ("TOKEN");    
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."UK1PMLQHJYENJRCAAPX6R575HQ" UNIQUE NULLS DISTINCT ("API_KEY");           
ALTER TABLE "PUBLIC"."RESOURCE_GRANTS" ADD CONSTRAINT "PUBLIC"."UK_RESOURCE_GRANT" UNIQUE NULLS DISTINCT ("RESOURCE_TYPE", "RESOURCE_ID", "PRINCIPAL_TYPE", "PRINCIPAL_ID", "PERMISSION");     
ALTER TABLE "PUBLIC"."FILE_RUN_EVENTS" ADD CONSTRAINT "PUBLIC"."UK_FILE_RUN_EVENTS_DEDUP" UNIQUE NULLS DISTINCT ("TEAM_ID", "DEDUP_KEY");      
ALTER TABLE "PUBLIC"."TEAM_MEMBERSHIPS" ADD CONSTRAINT "PUBLIC"."UKC436MCAXH2AVJ0TCPDJEGSIMG" UNIQUE NULLS DISTINCT ("TEAM_ID", "USER_ID");    
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_USAGE_COUNTER" ADD CONSTRAINT "PUBLIC"."UK_USAGE_COUNTER_PERIOD_CATEGORY" UNIQUE NULLS DISTINCT ("PERIOD_START", "CATEGORY");               
ALTER TABLE "PUBLIC"."USER_SERVER_CERTIFICATES" ADD CONSTRAINT "PUBLIC"."UKSLQBVI17BL2IAYCBIIEIT7MPC" UNIQUE NULLS DISTINCT ("USER_ID");       
ALTER TABLE "PUBLIC"."ACCOUNT_LINK_FREE_TIER_USAGE" ADD CONSTRAINT "PUBLIC"."UK_FREE_TIER_USAGE_PERIOD_CATEGORY" UNIQUE NULLS DISTINCT ("PERIOD_START", "CATEGORY");           
ALTER TABLE "PUBLIC"."API_KEYS" ADD CONSTRAINT "PUBLIC"."IDX_API_KEY_HASH" UNIQUE NULLS DISTINCT ("KEY_HASH"); 
ALTER TABLE "PUBLIC"."FILE_SHARES" ADD CONSTRAINT "PUBLIC"."FKSTAL2STAXCR9R48MX3XLCCXKO" FOREIGN KEY("STORED_FILE_ID") REFERENCES "PUBLIC"."STORED_FILES"("STORED_FILE_ID") NOCHECK;           
ALTER TABLE "PUBLIC"."FOLDERS" ADD CONSTRAINT "PUBLIC"."FK5B5P96EWK9MSG1OMQHL0VTTOP" FOREIGN KEY("OWNER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") ON DELETE CASCADE NOCHECK; 
ALTER TABLE "PUBLIC"."WORKFLOW_PARTICIPANTS" ADD CONSTRAINT "PUBLIC"."FKQVTV277FU89BE9V9JPJ7SHM02" FOREIGN KEY("WORKFLOW_SESSION_ID") REFERENCES "PUBLIC"."WORKFLOW_SESSIONS"("ID") NOCHECK;   
ALTER TABLE "PUBLIC"."FILE_SHARE_ACCESSES" ADD CONSTRAINT "PUBLIC"."FK6JE76T40HQA23JE0JP2SDK3HO" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;        
ALTER TABLE "PUBLIC"."USER_SETTINGS" ADD CONSTRAINT "PUBLIC"."FK8V82NJ88RMAI0NYCK19F873DW" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;              
ALTER TABLE "PUBLIC"."WORKFLOW_SESSIONS" ADD CONSTRAINT "PUBLIC"."FKI2D4G6VU7DEEBGGJ09QTBQBM9" FOREIGN KEY("ORIGINAL_FILE_ID") REFERENCES "PUBLIC"."STORED_FILES"("STORED_FILE_ID") NOCHECK;   
ALTER TABLE "PUBLIC"."WORKFLOW_PARTICIPANTS" ADD CONSTRAINT "PUBLIC"."FKP1KRWP3M2YN2UTJ46MOY1HVP" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;       
ALTER TABLE "PUBLIC"."WORKFLOW_SESSIONS" ADD CONSTRAINT "PUBLIC"."FKGMVGAVNLB7337VYB9IIRSKLJG" FOREIGN KEY("OWNER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;         
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."FKFN1EL0GW3HS74IW4KTMLGJC6X" FOREIGN KEY("OWNER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;              
ALTER TABLE "PUBLIC"."TEAM_MEMBERSHIPS" ADD CONSTRAINT "PUBLIC"."FKDQWTO3I1W1KXARNESB33YDSMS" FOREIGN KEY("TEAM_ID") REFERENCES "PUBLIC"."TEAMS"("TEAM_ID") NOCHECK;           
ALTER TABLE "PUBLIC"."WORKFLOW_SESSIONS" ADD CONSTRAINT "PUBLIC"."FK7AY2YOP11H7EIVSJ6W1OW5B7M" FOREIGN KEY("PROCESSED_FILE_ID") REFERENCES "PUBLIC"."STORED_FILES"("STORED_FILE_ID") NOCHECK;  
ALTER TABLE "PUBLIC"."PARTICIPANT_NOTIFICATIONS" ADD CONSTRAINT "PUBLIC"."FKG18L05TMG19VT5HFD16I38XNA" FOREIGN KEY("PARTICIPANT_ID") REFERENCES "PUBLIC"."WORKFLOW_PARTICIPANTS"("ID") NOCHECK;
ALTER TABLE "PUBLIC"."TEAM_MEMBERSHIPS" ADD CONSTRAINT "PUBLIC"."FKGHEHY5LOXLCHIV38PG888M6JY" FOREIGN KEY("INVITED_BY_USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;
ALTER TABLE "PUBLIC"."RESOURCE_GRANTS" ADD CONSTRAINT "PUBLIC"."FKL7H7IJ1N1E9O5SSBQ9KF4B921" FOREIGN KEY("GRANTED_BY_USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK; 
ALTER TABLE "PUBLIC"."AUTHORITIES" ADD CONSTRAINT "PUBLIC"."FKK91UPMBUEYIM93V469WJ7B2QH" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."FKJ70GWO45EX3TX60TTLHMY1196" FOREIGN KEY("WORKFLOW_SESSION_ID") REFERENCES "PUBLIC"."WORKFLOW_SESSIONS"("ID") NOCHECK;            
ALTER TABLE "PUBLIC"."FOLDERS" ADD CONSTRAINT "PUBLIC"."FKIOHFYLSA0E068VFRH56NWQV5W" FOREIGN KEY("PARENT_FOLDER_ID") REFERENCES "PUBLIC"."FOLDERS"("FOLDER_ID") ON DELETE CASCADE NOCHECK;     
ALTER TABLE "PUBLIC"."USER_SERVER_CERTIFICATES" ADD CONSTRAINT "PUBLIC"."FKFAV8UCB74TCJMNFI9KJX352PX" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;   
ALTER TABLE "PUBLIC"."STORED_FILES" ADD CONSTRAINT "PUBLIC"."FK8TVQTKF0RBB0WCEU3XGQAMDCF" FOREIGN KEY("FOLDER_ID") REFERENCES "PUBLIC"."FOLDERS"("FOLDER_ID") ON DELETE SET NULL NOCHECK;      
ALTER TABLE "PUBLIC"."USERS" ADD CONSTRAINT "PUBLIC"."FKFJWS1RDRUAB2BQG7QIPOQF65R" FOREIGN KEY("TEAM_ID") REFERENCES "PUBLIC"."TEAMS"("TEAM_ID") NOCHECK;      
ALTER TABLE "PUBLIC"."FILE_SHARE_ACCESSES" ADD CONSTRAINT "PUBLIC"."FKQ6V4QH5LFCAWII0ABRVSJO5SG" FOREIGN KEY("FILE_SHARE_ID") REFERENCES "PUBLIC"."FILE_SHARES"("FILE_SHARE_ID") NOCHECK;      
ALTER TABLE "PUBLIC"."INTEGRATION_CONFIGS" ADD CONSTRAINT "PUBLIC"."FKFBEJRBMJNIL8UMRK6LE3BNNBB" FOREIGN KEY("OWNER_TEAM_ID") REFERENCES "PUBLIC"."TEAMS"("TEAM_ID") NOCHECK;  
ALTER TABLE "PUBLIC"."FILE_SHARES" ADD CONSTRAINT "PUBLIC"."FK9WVOVMY30I059ARG5MPXP3XG7" FOREIGN KEY("SHARED_WITH_USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;    
ALTER TABLE "PUBLIC"."TEAM_MEMBERSHIPS" ADD CONSTRAINT "PUBLIC"."FKDAGEUSNOMAILYETUIOXI55GFW" FOREIGN KEY("USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;           
ALTER TABLE "PUBLIC"."INTEGRATION_CONFIGS" ADD CONSTRAINT "PUBLIC"."FKKIVC06FBGUT8JVMU6N4O8J8FP" FOREIGN KEY("OWNER_USER_ID") REFERENCES "PUBLIC"."USERS"("USER_ID") NOCHECK;  
