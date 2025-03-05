INSERT INTO IMPORTER (name, revision, state, last_change, configuration)
VALUES ('cve', gen_random_uuid(), 0, now(), '{"cve":{"description":"CVE list v5","period":"1d","source":"https://github.com/CVEProject/cvelistV5"}}'::jsonb)
ON CONFLICT (name) DO UPDATE
SET
  revision=EXCLUDED.revision,
  configuration=EXCLUDED.configuration
;

INSERT INTO IMPORTER (name, revision, state, last_change, configuration)
VALUES ('redhat-csaf', gen_random_uuid(), 0, now(), '{"csaf":{"description":"All Red Hat CSAF data","fetchRetries":50,"period":"1d","source":"redhat.com"}}'::jsonb)
ON CONFLICT (name) DO UPDATE
SET
  revision=EXCLUDED.revision,
  configuration=EXCLUDED.configuration
;

INSERT INTO IMPORTER (name, revision, state, last_change, configuration)
VALUES ('redhat-sboms', gen_random_uuid(), 0, now(), '{"sbom":{"description":"All Red Hat SBOMs","fetchRetries":50,"keys":["https://access.redhat.com/security/data/97f5eac4.txt#77E79ABE93673533ED09EBE2DCE3823597F5EAC4"],"period":"1d","source":"https://access.redhat.com/security/data/sbom/beta/"}}'::jsonb)
ON CONFLICT (name) DO UPDATE
SET
  revision=EXCLUDED.revision,
  configuration=EXCLUDED.configuration
;
