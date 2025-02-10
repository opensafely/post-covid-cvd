#!/bin/bash

# Define the directory
TARGET_DIR="codelists"

# List of allowed files
allowed_files=(
"user-RochelleKnight-confirmed-hospitalised-covid-19.csv"
"opensafely-covid-identification-in-primary-care-probable-covid-positive-test.csv"
"opensafely-covid-identification-in-primary-care-probable-covid-clinical-code.csv"
"opensafely-covid-identification-in-primary-care-probable-covid-sequelae.csv"
"user-elsie_horne-ami_snomed.csv"
"user-RochelleKnight-ami_icd10.csv"
"user-tomsrenin-other_art_embol.csv"
"user-elsie_horne-other_arterial_embolism_icd10.csv"
"user-elsie_horne-stroke_isch_snomed.csv"
"user-RochelleKnight-stroke_isch_icd10.csv"
"user-tomsrenin-dvt_main.csv"
"user-tomsrenin-dvt-preg.csv"
"user-RochelleKnight-dvt_dvt_icd10.csv"
"user-elsie_horne-dvt_pregnancy_icd10.csv"
"user-elsie_horne-dvt_icvt_snomed.csv"
"user-elsie_horne-dvt_icvt_icd10.csv"
"user-elsie_horne-icvt_pregnancy_icd10.csv"
"user-tomsrenin-dvt-other.csv"
"user-elsie_horne-other_dvt_icd10.csv"
"user-RochelleKnight-pe_icd10.csv"
"user-elsie_horne-pe_snomed.csv"
"user-tomsrenin-pvt.csv"
"user-elsie_horne-portal_vein_thrombosis_icd10.csv"
"user-elsie_horne-hf_snomed.csv"
"user-RochelleKnight-hf_icd10.csv"
"user-hjforbes-angina_snomed.csv"
"user-RochelleKnight-angina_icd10.csv"
"user-hjforbes-tia_snomed.csv"
"user-RochelleKnight-tia_icd10.csv"
"user-elsie_horne-stroke_sah_hs_snomed.csv"
"user-RochelleKnight-stroke_sah_hs_icd10.csv"
"user-RochelleKnight-prostate_cancer_snomed.csv"
"user-RochelleKnight-prostate_cancer_icd10.csv"
"user-RochelleKnight-pregnancy_and_birth_snomed.csv"
"user-elsie_horne-cocp_dmd.csv"
"user-elsie_horne-hrt_dmd.csv"
"opensafely-ethnicity.csv"
"primis-covid19-vacc-uptake-eth2001.csv"
"opensafely-smoking-clear.csv"
"opensafely-smoking-unclear.csv"
"bristol-smoke-and-eversmoke.csv"
"user-elsie_horne-bmi_obesity_snomed.csv"
"user-elsie_horne-bmi_obesity_icd10.csv"
"primis-covid19-vacc-uptake-bmi.csv"
"opensafely-cholesterol-tests-numerical-value.csv"
"bristol-hdl-cholesterol.csv"
"primis-covid19-vacc-uptake-carer.csv"
"primis-covid19-vacc-uptake-notcarer.csv"
"primis-covid19-vacc-uptake-learndis.csv"
"primis-covid19-vacc-uptake-carehome.csv"
"primis-covid19-vacc-uptake-nursehome.csv"
"primis-covid19-vacc-uptake-domcare.csv"
"primis-covid19-vacc-uptake-longres.csv"
"primis-covid19-vacc-uptake-shield.csv"
"primis-covid19-vacc-uptake-nonshield.csv"
"primis-covid19-vacc-uptake-preg.csv"
"primis-covid19-vacc-uptake-pregdel.csv"
"primis-covid19-vacc-uptake-bmi_stage.csv"
"primis-covid19-vacc-uptake-sev_obesity.csv"
"primis-covid19-vacc-uptake-ast.csv"
"primis-covid19-vacc-uptake-astadm.csv"
"primis-covid19-vacc-uptake-astrx.csv"
"primis-covid19-vacc-uptake-resp_cov.csv"
"primis-covid19-vacc-uptake-cns_cov.csv"
"primis-covid19-vacc-uptake-spln_cov.csv"
"primis-covid19-vacc-uptake-diab.csv"
"primis-covid19-vacc-uptake-dmres.csv"
"primis-covid19-vacc-uptake-sev_mental.csv"
"primis-covid19-vacc-uptake-smhres.csv"
"primis-covid19-vacc-uptake-chd_cov.csv"
"primis-covid19-vacc-uptake-ckd_cov.csv"
"primis-covid19-vacc-uptake-ckd15.csv"
"primis-covid19-vacc-uptake-ckd35.csv"
"primis-covid19-vacc-uptake-cld.csv"
"primis-covid19-vacc-uptake-immdx_cov.csv"
"primis-covid19-vacc-uptake-immrx.csv"
"user-elsie_horne-dementia_snomed.csv"
"user-elsie_horne-dementia_icd10.csv"
"opensafely-dementia.csv"
)

# Ensure the directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist."
  exit 1
fi

# Change to the target directory
cd "$TARGET_DIR" || exit

# Remove all files except the allowed ones
for file in *; do
  if [[ ! " ${allowed_files[@]} " =~ " $file " ]]; then
    echo "Deleting: $file"
    rm -f "$file"
  fi
done

echo "Cleanup complete."
