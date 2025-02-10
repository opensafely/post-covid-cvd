# SETUP

from ehrql import codelist_from_csv

# EXPOSURE(S)

## COVID-19
covid_codes = codelist_from_csv(
    "codelists/user-RochelleKnight-confirmed-hospitalised-covid-19.csv",
    column="code"
)
covid_primary_care_positive_test = codelist_from_csv(
    "codelists/opensafely-covid-identification-in-primary-care-probable-covid-positive-test.csv",
    column="CTV3ID"
)
covid_primary_care_code = codelist_from_csv(
    "codelists/opensafely-covid-identification-in-primary-care-probable-covid-clinical-code.csv",
    column="CTV3ID"
)
covid_primary_care_sequalae = codelist_from_csv(
    "codelists/opensafely-covid-identification-in-primary-care-probable-covid-sequelae.csv",
    column="CTV3ID"
)

# OUTCOMES

## Acute myocardial infarction
ami_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-ami_snomed.csv",
    column="code",
)
ami_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-ami_icd10.csv",
    column="code",
)

# Other arterial embolism (AE) [contributes to composite ATE only]
other_ae_snomed = codelist_from_csv(
    "codelists/user-tomsrenin-other_art_embol.csv",
    column="code",
)
other_ae_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-other_arterial_embolism_icd10.csv",
    column="code",
)

## Ischaemic stroke
stroke_isch_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-stroke_isch_snomed.csv",
    column="code",
)
stroke_isch_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-stroke_isch_icd10.csv",  
    column="code",
)

## Composite arterial thrombotic event (ATE)
ate_snomed = ami_snomed + other_ae_snomed + stroke_isch_snomed
ate_icd10 = ami_icd10 + other_ae_icd10 + stroke_isch_icd10

## Deep vein thrombosis (DVT) [includes during pregnancy]
dvt_nonpreg_snomed = codelist_from_csv(
    "codelists/user-tomsrenin-dvt_main.csv",    
    column="code",
)
dvt_preg_snomed = codelist_from_csv(
    "codelists/user-tomsrenin-dvt-preg.csv",   
    column="code",
)
dvt_snomed = dvt_nonpreg_snomed + dvt_preg_snomed
dvt_nonpreg_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-dvt_dvt_icd10.csv",   
    column="code",
)
dvt_preg_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-dvt_pregnancy_icd10.csv",   
    column="code",
)
dvt_icd10 = dvt_nonpreg_icd10 + dvt_preg_icd10

## Intracranial venous thrombosis (ICVT) [includes during pregnancy; contributes to composite VTE only]
icvt_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-dvt_icvt_snomed.csv",    
    column="code",
)
icvt_nonpreg_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-dvt_icvt_icd10.csv",   
    column="code",
)
icvt_preg_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-icvt_pregnancy_icd10.csv",  
    column="code",
)
icvt_icd10 = icvt_nonpreg_icd10 + icvt_preg_icd10

## Other deep vein thrombosis [contributes to composite VTE only]
other_dvt_snomed = codelist_from_csv(
    "codelists/user-tomsrenin-dvt-other.csv",   
    column="code",
)
other_dvt_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-other_dvt_icd10.csv",    
    column="code",
)

## Pulmonary embolism (PE)
pe_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-pe_icd10.csv",    
    column="code",
)
pe_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-pe_snomed.csv",    
    column="code",
)

## Portal vein thrombosis (PVT) [contributes to composite VTE only]
pvt_snomed = codelist_from_csv(
    "codelists/user-tomsrenin-pvt.csv",   
    column="code",
)
pvt_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-portal_vein_thrombosis_icd10.csv",  
    column="code",
)

## Composite venous thrombotic event (VTE)
vte_snomed = dvt_snomed + icvt_snomed + other_dvt_snomed + pe_snomed + pvt_snomed
vte_icd10 = dvt_icd10 + icvt_icd10 + other_dvt_icd10 + pe_icd10 + pvt_icd10

## Heart failure
hf_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-hf_snomed.csv",   
    column="code",
)
hf_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-hf_icd10.csv",  
    column="code",
)

## Angina
angina_snomed = codelist_from_csv(
    "codelists/user-hjforbes-angina_snomed.csv",  
    column="code",
)
angina_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-angina_icd10.csv",   
    column="code",
)

## Transient ischaemic attack
tia_snomed = codelist_from_csv(
    "codelists/user-hjforbes-tia_snomed.csv", 
    column="code",
)
tia_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-tia_icd10.csv", 
    column="code",
)

## Subarachnoid haemorrhage and haemorrhagic stroke
stroke_sahhs_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-stroke_sah_hs_snomed.csv",
    column="code",
)
stroke_sahhs_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-stroke_sah_hs_icd10.csv",
    column="code",
)

# QUALITY ASSURANCE 

## Prostate cancer
prostate_cancer_snomed = codelist_from_csv(
    "codelists/user-RochelleKnight-prostate_cancer_snomed.csv",
    column="code"
)
prostate_cancer_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-prostate_cancer_icd10.csv",
    column="code"
)

## Pregnancy
pregnancy_snomed = codelist_from_csv(
    "codelists/user-RochelleKnight-pregnancy_and_birth_snomed.csv",
    column="code"
)

## Combined oral contraceptive pill
cocp_dmd = codelist_from_csv(
    "codelists/user-elsie_horne-cocp_dmd.csv",
    column="dmd_id"
)

## Hormone replacement therapy
hrt_dmd = codelist_from_csv(
    "codelists/user-elsie_horne-hrt_dmd.csv",
    column="dmd_id"
)

# COVARIATES(S) [TO BE SORTED]

## Ethnicity
opensafely_ethnicity_codes_6 = codelist_from_csv(
    "codelists/opensafely-ethnicity.csv",
    column="Code",
    category_column="Grouping_6"
)
primis_covid19_vacc_update_ethnicity = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-eth2001.csv",
    column="code",
    category_column="grouping_6_id"
)

## Smoking
smoking_clear = codelist_from_csv(
    "codelists/opensafely-smoking-clear.csv",
    column="CTV3Code",
    category_column="Category"
)
smoking_unclear = codelist_from_csv(
    "codelists/opensafely-smoking-unclear.csv",
    column="CTV3Code",
    category_column="Category"
)
ever_current_smoke = codelist_from_csv(
    "codelists/bristol-smoke-and-eversmoke.csv",
    column="code"
)

## BMI
bmi_obesity_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-bmi_obesity_snomed.csv",
    column="code"
)
bmi_obesity_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-bmi_obesity_icd10.csv",
    column="code"
)
bmi_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-bmi.csv",
    column="code"
)

## Total Cholesterol
cholesterol_snomed = codelist_from_csv(
    "codelists/opensafely-cholesterol-tests-numerical-value.csv",
    column="code"
)

## HDL Cholesterol
hdl_cholesterol_snomed = codelist_from_csv(
    "codelists/bristol-hdl-cholesterol.csv",
    column="code"
)

## Carer codes
carer_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-carer.csv",
    column="code"
)

## No longer a carer codes
notcarer_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-notcarer.csv",
    column="code"
)

## Wider Learning Disability
learndis_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-learndis.csv",
    column="code"
)

## Employed by Care Home codes
carehome_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-carehome.csv",
    column="code"
)

## Employed by nursing home codes
nursehome_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-nursehome.csv",
    column="code"
)

## Employed by domiciliary care provider codes
domcare_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-domcare.csv",
    column="code"
)

## Patients in long-stay nursing and residential care
longres_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-longres.csv",
    column="code"
)

## High Risk from COVID-19 code
shield_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-shield.csv",
    column="code"
)

## Lower Risk from COVID-19 codes
nonshield_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-nonshield.csv",
    column="code"
)

# JCVI GROUPS [TO BE SORTED]
# CHECK IF primis-covid19-vacc-uptake/hhld_imdef/v1 IS NEEDED

## Pregnancy codes
preg_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-preg.csv",
    column="code"
)

## Pregnancy or Delivery codes
pregdel_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-pregdel.csv",
    column="code"
)

## All BMI coded terms
bmi_stage_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-bmi_stage.csv",
    column="code"
)

## Severe Obesity code recorded
sev_obesity_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-sev_obesity.csv",
    column="code"
)

## Asthma Diagnosis code
ast_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-ast.csv",
    column="code"
)

## Asthma Admission codes
astadm_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-astadm.csv",
    column="code"
)

## Asthma systemic steroid prescription codes
astrx_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-astrx.csv",
    column="code"
)

## Chronic Respiratory Disease
resp_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-resp_cov.csv",
    column="code"
)

## Chronic Neurological Disease including Significant Learning Disorder
cns_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-cns_cov.csv",
    column="code"
)

## Asplenia or Dysfunction of the Spleen codes
spln_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-spln_cov.csv",
    column="code"
)

## Diabetes diagnosis codes
diab_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-diab.csv",
    column="code"
)

## Diabetes resolved codes
dmres_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-dmres.csv",
    column="code"
)

## Severe Mental Illness codes
sev_mental_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-sev_mental.csv",
    column="code"
)

## Remission codes relating to Severe Mental Illness
smhres_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-smhres.csv",
    column="code"
)

## Chronic heart disease codes
chd_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-chd_cov.csv",
    column="code"
)

## Chronic kidney disease diagnostic codes
ckd_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-ckd_cov.csv",
    column="code"
)

## Chronic kidney disease codes - all stages
ckd15_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-ckd15.csv",
    column="code"
)

## Chronic kidney disease codes-stages 3 - 5
ckd35_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-ckd35.csv",
    column="code"
)

## Chronic Liver disease codes
cld_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-cld.csv",
    column="code"
)

## Immunosuppression diagnosis codes
immdx_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-immdx_cov.csv",
    column="code"
)

## Immunosuppression medication codes
immrx_primis = codelist_from_csv(
    "codelists/primis-covid19-vacc-uptake-immrx.csv",
    column="code"
)

## Stroke Ischaemic (Ischaemic Stroke)
stroke_isch_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-stroke_isch_snomed.csv",
    column="code"
)

stroke_isch_icd10 = codelist_from_csv(
    "codelists/user-RochelleKnight-stroke_isch_icd10.csv",
    column="code"
)

## Dementia (added ctv3)
dementia_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-dementia_snomed.csv",
    column="code"
)

dementia_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-dementia_icd10.csv",
    column="code"
)

dementia_ctv3 = codelist_from_csv(
    "codelists/opensafely-dementia.csv",
    column="CTV3ID"
)

dementia_vascular_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-dementia_vascular_snomed.csv",
    column="code"
)

dementia_vascular_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-dementia_vascular_icd10.csv",
    column="code"
)

## Liver disease
liver_disease_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-liver_disease_snomed.csv",
    column="code"
)

liver_disease_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-liver_disease_icd10.csv",
    column="code"
)

## Chronic Kidney disease
ckd_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-ckd_snomed.csv",
    column="code"
)

ckd_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-ckd_icd10.csv",
    column="code"
)

## Cancer
cancer_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-cancer_snomed.csv",
    column="code"
)

cancer_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-cancer_icd10.csv",
    column="code"
)

## Hypertension (added ctv3 codes)
hypertension_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-hypertension_icd10.csv",
    column="code"
)
hypertension_drugs_dmd = codelist_from_csv(
    "codelists/user-elsie_horne-hypertension_drugs_dmd.csv",
    column="dmd_id"
)
hypertension_snomed = codelist_from_csv(
    "codelists/nhsd-primary-care-domain-refsets-hyp_cod.csv",
    column="code"
)
hypertension_ctv3 = codelist_from_csv(
    "codelists/opensafely-hypertension.csv",
    column="CTV3ID"
)

## Diabetes
diabetes_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-diabetes_icd10.csv",
    column="code"
)
diabetes_drugs_dmd = codelist_from_csv(
    "codelists/user-elsie_horne-diabetes_drugs_dmd.csv",
    column="dmd_id"
)
diabetes_snomed = codelist_from_csv(
    "codelists/user-elsie_horne-diabetes_snomed.csv",
    column="code"
)   

## Depression
depression_snomed = codelist_from_csv(
    "codelists/user-hjforbes-depression-symptoms-and-diagnoses.csv",
    column="code"
)
depression_icd10 = codelist_from_csv(
    "codelists/user-kurttaylor-depression_icd10.csv",
    column="code",
)

## Acute Myocardial Infarction
### ami_snomed defined under OUTCOME(S)
### ami_snomed defined under OUTCOME(S)
ami_prior_icd10 = codelist_from_csv(
    "codelists/user-elsie_horne-ami_prior_icd10.csv",
    column="code"
)