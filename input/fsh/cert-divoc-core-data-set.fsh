Logical:        CertDIVOC
Title:          "Certificate - DIVOC Verifiable Credential Logical Model"
Description:    "Data elements for the DIVOC Core Data Set.

The official DIVOC documentation appears to be at <https://divoc.digit.org>. However, this does not include a full list of elements included in DIVOC certificates.

There is a JSON-LD context referenced in DIVOC certificate examples (`https://cowin.gov.in/credentials/vaccination/v1`), which would provide some element-level information, but this URL does not resolve. There is a copy of this JSON-LD context at <https://github.com/egovernments/DIVOC/blob/main/vaccination-context/vaccination-context.js>.

It was not possible to find any online documentation regarding DIVOC proof of testing. Information on this was provided by the DIVOC team via email.

Some element descriptions in this logical model provide details that are not in publicly available DIVOC documentation."

* ^url = "http://worldhealthorganization.github.io/ddcc/StructureDefinition/CertDIVOC"
* ^version = "1"
* ^abstract = true
* ^status = #draft

* context 1..* string "Context (JSON-LD) - should actually be `@context` but this name isn't supported by FHIR."
* type 1..* string "Type" "JSON-LD Type"
* issuer 1..1 string "Issuer identifier" "Issuer identifier URI. generally a DID"
* issuanceDate 1..1 dateTime "issuanceDate" "Date and time when a credential becomes valid"
* nonTransferable 0..1 boolean "Non Trasnferability" "indicates that a verifiable credential must only be encapsulated into a verifiable presentation whose proof was issued by the credentialSubject"
* credentialSubject 1..1 BackboneElement "CredentialSubject" "Contains claims about one or morebjects (Patients)"
  * id 0..1 string "id"
  * type 1..* string "type" "Type of credential. Generally 'Person'"
  * uhid 0..1 string "another id"
  * refId 0..1 string "reference id"
  * name 0..1 string "A name associated with the patient"
  * gender 0..1 string "Gender (`Male` or `Female`; unknown if there are other options)"
  * sex 0..1 string "Sex (not used in examples; presumably `Male` or `Female`; unknown if there are other options)"
  * age 0..1 string "Age"
  * dob 0..1 date "The date of birth for the individual (V2 only)"
  * nationality 0..1 string "Nationality"
  * address 0..1 BackboneElement "Address"
    * streetAddress 0..1 string "Line 1 of the address"
    * streetAddress2 0..1 string "Line 2 of the address"
    * district 0..1 string "District name (aka county)"
    * city 0..1 string "Name of city, town etc."
    * addressRegion 0..1 string "Sub-unit of country (abbreviations ok)"
    * addressCountry 0..1 string "Country (e.g. may be ISO 3166 2 or 3 letter code)"
    * postalCode 0..1 string "Postal code for area"
* evidence 0..* BackboneElement "Evidence" "Vaccination Information"
  * id 0..1 string "id"
  * feedbackUrl 0..1 string "URL for feedback"
  * infoUrl 0..1 string "URL for more information on this record"
  * certificateId 0..1 string "Certificate Unique Identifier"
  * type 1..* string "type" "Type of evidence record. Generally `Vaccination` or `TestDetails`"
  * batch 0..1 string "Vaccine lot number"
  * vaccine 0..1 string "Vaccine description. Might include vaccine type and brand"
  * manufacturer 0..1 string "Name of the Vaccine/Test Manufacturer"
  * date 0..1 dateTime "Date of immunization"
  * effectiveStart 0..1 date "Effective immunization start date"
  * effectiveUntil 0..1 date "Effective immunization end date"
  * dose 0..1 positiveInt "Dose Number"
  * totalDoses 0..1 positiveInt "Total doses for this vaccine protocol regimen"
  * verifier 0..1 BackboneElement "Verifier" "Practitioner that oversaw the application"
    * name 0..1 string "Name of the practitioner"
  * facility 0..1 BackboneElement "Facility" "Facility where the immunization took place"
    * name 0..1 string "Name of the facility/entity"
    * address 0..1 Address "Address of the facility"
      * streetAddress 0..1 string "Line 1 of the address"
      * streetAddress2 0..1 string "Line 2 of the address"
      * district 0..1 string "District name (aka county)"
      * city 0..1 string "Name of city, town etc."
      * addressRegion 0..1 string "Sub-unit of country (abbreviations ok)"
      * addressCountry 0..1 string "Country (e.g. may be ISO 3166 2 or 3 letter code)"
      * addressCountry from http://hl7.org/fhir/ValueSet/iso3166-1-3 (preferred)
      * postalCode 0..1 string "Postal code for area"
  * icd11Code 0..1 string "ICD-11 code of this vaccine type (no binding information in spec)" "The specification for DIVOC does not provide any information beyond that this is an ICD-11 code, so correspondingly there is no required binding to a specific ValueSet in this logical model."
  * icd11Code from WHO_DDCC_Vaccines_COVID_19 (preferred)
  * prophylaxis 0..1 string "Descriptive details of the vaccine type"

  // Lab test specific elements
  * testName 0..1 string "Lab test results: Test name"
  * testType 0..1 string "Lab test results: Type of test, either `RT-PCR` or `Rapid Antigen Test (RAT)`"
  * testType from LabTestTypeDivocValueSet (required)
  * sampleOrigin 0..1 string "Lab test results: Type of sample that was taken (e.g., `nasal swab`"
  * sampleOrigin from LabTestSampleOriginDivocValueSet (required)
  * disease 0..1 string "Lab test results: Disease or agent targeted"
  * disease from LabTestPathogenDivocValueSet (required)
  * sampleCollectionTimestamp 0..1 dateTime "Lab test results: Sample collection date and time; complete date, with time and time zone, following ISO 8601"
  * resultTimestamp 0..1 dateTime "Lab test results: Results date and time; complete date, with time and time zone, following ISO 8601"
  * result 0..1 string "Lab test results: result of test"
  * result from LabTestQualitativeResultDivocValueSet
* proof 1..* BackboneElement "Proof" "One or more cryptographic proofs that can be used to detect tampering and verify the authorship of a credential or presentation"
  * type 0..1 string "Type of proof"
  * created 0..1  dateTime "Signature date and time"
  * verificationMethod 1..1 string "Resolvable issuer identifier"
  * proofPurpose 0..1 string "Purpose of the signature" "Clearly expresses the purpose for the proof and ensures this information is protected by the signature"
  * jws 1..1 string "Signature"