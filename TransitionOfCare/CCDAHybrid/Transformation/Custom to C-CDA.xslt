<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xs fn">
	<xsl:output method="xml" encoding="UTF-8" byte-order-mark="no" indent="yes"/>
	<xsl:template match="/">
		<ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
			<xsl:attribute name="xsi:schemaLocation" select="'urn:hl7-org:v3 CDA_SDTC.xsd'"/>
			<xsl:for-each select="*:TransitionOfCare[fn:namespace-uri() eq '']">
				<xsl:variable name="var52_cur" as="node()" select="."/>
				<xsl:variable name="var51_resultof_replace" as="xs:string" select="replace(format-dateTime(fn:current-dateTime(), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
				<xsl:variable name="var50_Author" as="node()" select="*:Author[fn:namespace-uri() eq '']"/>
				<realmCode>
					<xsl:attribute name="code" namespace="" select="'US'"/>
				</realmCode>
				<typeId>
					<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.1.3'"/>
					<xsl:attribute name="extension" namespace="" select="'POCD_HD000040'"/>
				</typeId>
				<templateId>
					<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.1.15'"/>
				</templateId>
				<templateId>
					<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.1.15'"/>
					<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
				</templateId>
				<id>
					<xsl:for-each select="@Guid">
						<xsl:attribute name="root" namespace="" select="fn:string(.)"/>
					</xsl:for-each>
				</id>
				<code>
					<xsl:attribute name="code" namespace="" select="'52521-2'"/>
					<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
					<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
					<xsl:attribute name="displayName" namespace="" select="'Overall Plan of Care/Advance Care Directives'"/>
				</code>
				<title>Care Plan</title>
				<effectiveTime>
					<xsl:attribute name="value" namespace="" select="$var51_resultof_replace"/>
				</effectiveTime>
				<confidentialityCode>
					<xsl:attribute name="code" namespace="" select="'N'"/>
					<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.5.25'"/>
					<xsl:attribute name="displayName" namespace="" select="'Normal'"/>
				</confidentialityCode>
				<languageCode>
					<xsl:attribute name="code" namespace="" select="'en-US'"/>
				</languageCode>
				<xsl:variable name="var2_Patient" as="node()" select="*:Patient[fn:namespace-uri() eq '']"/>
				<xsl:variable name="var1_Address" as="node()" select="$var2_Patient/*:Address[fn:namespace-uri() eq '']"/>
				<recordTarget>
					<patientRole>
						<id>
							<xsl:attribute name="root" namespace="" select="'~~ Georgia Medcaid OID HERE ~~'"/>
							<xsl:attribute name="extension" namespace="" select="fn:string($var2_Patient/*:MedicaidId[fn:namespace-uri() eq ''])"/>
						</id>
						<addr>
							<xsl:attribute name="use" namespace="" select="'WP'"/>
							<state>
								<xsl:sequence select="fn:string($var1_Address/*:State[fn:namespace-uri() eq ''])"/>
							</state>
							<city>
								<xsl:sequence select="fn:string($var1_Address/*:City[fn:namespace-uri() eq ''])"/>
							</city>
							<postalCode>
								<xsl:sequence select="fn:string($var1_Address/*:ZipCode[fn:namespace-uri() eq ''])"/>
							</postalCode>
							<streetAddressLine>
								<xsl:sequence select="fn:string($var1_Address/*:AddressLine[fn:namespace-uri() eq ''])"/>
							</streetAddressLine>
						</addr>
						<telecom>
							<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI(fn:string($var2_Patient/*:Phone[fn:namespace-uri() eq ''])))"/>
							<xsl:attribute name="use" namespace="" select="'HP'"/>
						</telecom>
						<patient>
							<name>
								<family>
									<xsl:sequence select="fn:string($var2_Patient/*:LastName[fn:namespace-uri() eq ''])"/>
								</family>
								<given>
									<xsl:sequence select="fn:string($var2_Patient/*:FirstName[fn:namespace-uri() eq ''])"/>
								</given>
							</name>
							<administrativeGenderCode>
								<xsl:attribute name="code" namespace="" select="fn:string($var2_Patient/*:Gender[fn:namespace-uri() eq ''])"/>
								<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.1.11.1'"/>
								<xsl:attribute name="codeSystemName" namespace="" select="'AdministrativeGender'"/>
							</administrativeGenderCode>
							<birthTime>
								<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string($var2_Patient/*:DateOfBirth[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
							</birthTime>
							<raceCode>
								<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
							</raceCode>
							<ethnicGroupCode>
								<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
							</ethnicGroupCode>
							<languageCommunication>
								<languageCode>
									<xsl:attribute name="code" namespace="" select="'eng'"/>
								</languageCode>
							</languageCommunication>
						</patient>
					</patientRole>
				</recordTarget>
				<xsl:variable name="var8_Author" as="node()" select="$var50_Author"/>
				<xsl:variable name="var7_Address" as="node()" select="$var8_Author/*:Address[fn:namespace-uri() eq '']"/>
				<xsl:variable name="var6_Name_as_string" as="xs:string" select="fn:string($var8_Author/*:Name[fn:namespace-uri() eq ''])"/>
				<author>
					<time>
						<xsl:attribute name="value" namespace="" select="$var51_resultof_replace"/>
					</time>
					<assignedAuthor>
						<id>
							<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
						</id>
						<addr>
							<state>
								<xsl:sequence select="fn:string($var7_Address/*:State[fn:namespace-uri() eq ''])"/>
							</state>
							<city>
								<xsl:sequence select="fn:string($var7_Address/*:City[fn:namespace-uri() eq ''])"/>
							</city>
							<postalCode>
								<xsl:sequence select="fn:string($var7_Address/*:ZipCode[fn:namespace-uri() eq ''])"/>
							</postalCode>
							<streetAddressLine>
								<xsl:sequence select="fn:string($var7_Address/*:AddressLine[fn:namespace-uri() eq ''])"/>
							</streetAddressLine>
						</addr>
						<telecom>
							<xsl:for-each select="($var8_Author/*:PhoneExtension[fn:namespace-uri() eq ''])[fn:not((fn:translate(fn:string(@xsi:nil), 'true ', '1') = '1'))]">
								<xsl:variable name="var5_cur_as_string" as="xs:string" select="fn:string(.)"/>
								<xsl:variable name="var4_Phone_as_string" as="xs:string" select="fn:string($var8_Author/*:Phone[fn:namespace-uri() eq ''])"/>
								<xsl:variable name="var3_test_resultof_equal" as="xs:string">
									<xsl:choose>
										<xsl:when test="($var5_cur_as_string = '')">
											<xsl:sequence select="$var4_Phone_as_string"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:sequence select="fn:concat(fn:concat($var4_Phone_as_string, ' '), $var5_cur_as_string)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI($var3_test_resultof_equal))"/>
							</xsl:for-each>
							<xsl:attribute name="use" namespace="" select="'WP'"/>
						</telecom>
						<assignedAuthoringDevice>
							<manufacturerModelName>
								<xsl:sequence select="$var6_Name_as_string"/>
							</manufacturerModelName>
							<softwareName>
								<xsl:sequence select="$var6_Name_as_string"/>
							</softwareName>
						</assignedAuthoringDevice>
					</assignedAuthor>
				</author>
				<xsl:variable name="var13_Author" as="node()" select="$var50_Author"/>
				<xsl:variable name="var12_Address" as="node()" select="$var13_Author/*:Address[fn:namespace-uri() eq '']"/>
				<custodian>
					<assignedCustodian>
						<representedCustodianOrganization>
							<id>
								<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
							</id>
							<name>
								<xsl:sequence select="fn:string($var13_Author/*:Name[fn:namespace-uri() eq ''])"/>
							</name>
							<telecom>
								<xsl:for-each select="($var13_Author/*:PhoneExtension[fn:namespace-uri() eq ''])[fn:not((fn:translate(fn:string(@xsi:nil), 'true ', '1') = '1'))]">
									<xsl:variable name="var11_cur_as_string" as="xs:string" select="fn:string(.)"/>
									<xsl:variable name="var10_Phone_as_string" as="xs:string" select="fn:string($var13_Author/*:Phone[fn:namespace-uri() eq ''])"/>
									<xsl:variable name="var9_test_resultof_equal" as="xs:string">
										<xsl:choose>
											<xsl:when test="($var11_cur_as_string = '')">
												<xsl:sequence select="$var10_Phone_as_string"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:sequence select="fn:concat(fn:concat($var10_Phone_as_string, ' '), $var11_cur_as_string)"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI($var9_test_resultof_equal))"/>
								</xsl:for-each>
								<xsl:attribute name="use" namespace="" select="'WP'"/>
							</telecom>
							<addr>
								<state>
									<xsl:sequence select="fn:string($var12_Address/*:State[fn:namespace-uri() eq ''])"/>
								</state>
								<city>
									<xsl:sequence select="fn:string($var12_Address/*:City[fn:namespace-uri() eq ''])"/>
								</city>
								<postalCode>
									<xsl:sequence select="fn:string($var12_Address/*:ZipCode[fn:namespace-uri() eq ''])"/>
								</postalCode>
								<streetAddressLine>
									<xsl:sequence select="fn:string($var12_Address/*:AddressLine[fn:namespace-uri() eq ''])"/>
								</streetAddressLine>
							</addr>
						</representedCustodianOrganization>
					</assignedCustodian>
				</custodian>
				<documentationOf>
					<serviceEvent>
						<xsl:attribute name="classCode" namespace="" select="'PCPR'"/>
						<effectiveTime>
							<low>
								<xsl:attribute name="value" namespace="" select="$var51_resultof_replace"/>
							</low>
						</effectiveTime>
						<performer>
							<xsl:attribute name="typeCode" namespace="" select="'PRF'"/>
							<assignedEntity>
								<id>
									<xsl:attribute name="nullFlavor" namespace="" select="'NI'"/>
								</id>
								<assignedPerson>
									<name>
										<xsl:attribute name="nullFlavor" namespace="" select="'NI'"/>
									</name>
								</assignedPerson>
							</assignedEntity>
						</performer>
					</serviceEvent>
				</documentationOf>
				<xsl:for-each select="*:CaseManagement[fn:namespace-uri() eq '']">
					<xsl:variable name="var49_PharmacyLockIn" as="node()?" select="$var52_cur/*:PharmacyLockIn[fn:namespace-uri() eq '']"/>
					<xsl:variable name="var47_CarePlan" as="node()" select="*:CarePlan[fn:namespace-uri() eq '']"/>
					<xsl:variable name="var48_CaseManager" as="node()" select="*:CaseManager[fn:namespace-uri() eq '']"/>
					<component>
						<structuredBody>
							<component>
								<section>
									<xsl:attribute name="nullFlavor" namespace="" select="'NI'"/>
									<templateId>
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.2.61'"/>
									</templateId>
									<code>
										<xsl:attribute name="code" namespace="" select="'11383-7'"/>
										<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
										<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
										<xsl:attribute name="displayName" namespace="" select="'Health Status Evaluations and Outcomes Section'"/>
									</code>
									<title>Health Status Evaluations and Outcomes Section</title>
									<text>
										<table>
											<caption>Additional Care Plan Information</caption>
											<thead>
												<tr>
													<th>Name</th>
													<th>Value</th>
												</tr>
											</thead>
											<tbody>
												<xsl:variable name="var16_ProgramType" as="node()" select="*:ProgramType[fn:namespace-uri() eq '']"/>
												<xsl:variable name="var15_cur_as_string" as="xs:string" select="fn:string($var16_ProgramType)"/>
												<tr>
													<td>Programe Type</td>
													<xsl:variable name="var14_test_resultof_equal" as="xs:string?">
														<xsl:choose>
															<xsl:when test="($var15_cur_as_string = 'CM')">
																<xsl:sequence select="'Case Managed'"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:if test="($var15_cur_as_string = 'DM')">
																	<xsl:sequence select="'Disease Managed'"/>
																</xsl:if>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>
													<xsl:for-each select="$var14_test_resultof_equal">
														<td>
															<xsl:sequence select="."/>
														</td>
													</xsl:for-each>
												</tr>
												<xsl:variable name="var19_Program" as="node()" select="*:Program[fn:namespace-uri() eq '']"/>
												<xsl:variable name="var18_cur_as_string" as="xs:string" select="fn:string($var19_Program)"/>
												<tr>
													<td>Program</td>
													<xsl:variable name="var17_test_resultof_equal" as="xs:string?">
														<xsl:choose>
															<xsl:when test="($var18_cur_as_string = 'BH')">
																<xsl:sequence select="'Behavioral Health'"/>
															</xsl:when>
															<xsl:when test="($var18_cur_as_string = 'PH')">
																<xsl:sequence select="'Physical Health'"/>
															</xsl:when>
															<xsl:when test="($var18_cur_as_string = 'OB')">
																<xsl:sequence select="'Obstretrics'"/>
															</xsl:when>
															<xsl:when test="($var18_cur_as_string = 'AS')">
																<xsl:sequence select="'Asthma'"/>
															</xsl:when>
															<xsl:when test="($var18_cur_as_string = 'DB')">
																<xsl:sequence select="'Diabeties'"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:if test="($var18_cur_as_string = 'HT')">
																	<xsl:sequence select="'Hypertension'"/>
																</xsl:if>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>
													<xsl:for-each select="$var17_test_resultof_equal">
														<td>
															<xsl:sequence select="."/>
														</td>
													</xsl:for-each>
												</tr>
												<xsl:variable name="var21_CaseManager" as="node()" select="$var48_CaseManager"/>
												<xsl:variable name="var20_FirstName" as="node()" select="$var21_CaseManager/*:FirstName[fn:namespace-uri() eq '']"/>
												<tr>
													<td>Case Manager Name</td>
													<td>
														<xsl:sequence select="fn:concat(fn:concat(fn:string($var20_FirstName), ' '), fn:string($var21_CaseManager/*:LastName[fn:namespace-uri() eq '']))"/>
													</td>
												</tr>
												<xsl:variable name="var25_CaseManager" as="node()" select="$var48_CaseManager"/>
												<xsl:variable name="var24_Phone" as="node()" select="$var25_CaseManager/*:Phone[fn:namespace-uri() eq '']"/>
												<tr>
													<td>Case Manager Phone</td>
													<xsl:for-each select="($var25_CaseManager/*:PhoneExtension[fn:namespace-uri() eq ''])[fn:not((fn:translate(fn:string(@xsi:nil), 'true ', '1') = '1'))]">
														<xsl:variable name="var22_cur_as_string" as="xs:string" select="fn:string($var24_Phone)"/>
														<xsl:variable name="var23_cur_as_string" as="xs:string" select="fn:string(.)"/>
														<td>
															<xsl:choose>
																<xsl:when test="($var23_cur_as_string = '')">
																	<xsl:sequence select="$var22_cur_as_string"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:sequence select="fn:concat(fn:concat($var22_cur_as_string, ' '), $var23_cur_as_string)"/>
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</xsl:for-each>
												</tr>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var26_Name" as="node()" select="*:Pharmacy[fn:namespace-uri() eq '']/*:Name[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy Name</td>
														<td>
															<xsl:sequence select="fn:string($var26_Name)"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var27_NPI" as="node()" select="*:Pharmacy[fn:namespace-uri() eq '']/*:NPI[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy NPI</td>
														<td>
															<xsl:sequence select="fn:string($var27_NPI)"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var28_Name" as="node()" select="*:Provider[fn:namespace-uri() eq '']/*:Name[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy Provider Name</td>
														<td>
															<xsl:sequence select="fn:string($var28_Name)"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var29_NPI" as="node()" select="*:Provider[fn:namespace-uri() eq '']/*:NPI[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy Provider NPI</td>
														<td>
															<xsl:sequence select="fn:string($var29_NPI)"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var30_StartDate" as="node()" select="*:StartDate[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy Lock-In Start Date</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string($var30_StartDate)))"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var49_PharmacyLockIn">
													<xsl:variable name="var31_EndDate" as="node()" select="*:EndDate[fn:namespace-uri() eq '']"/>
													<tr>
														<td>Pharmacy Lock-In End Date</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string($var31_EndDate)))"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var52_cur/*:FosterCare[fn:namespace-uri() eq '']">
													<tr>
														<td>Was in Foster Care</td>
														<td>
															<xsl:sequence select="xs:string(xs:boolean(fn:string(.)))"/>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
										<xsl:comment select="'Internal Transition of Care v3 Contents'"/>
									</text>
								</section>
							</component>
							<xsl:variable name="var36_CarePlan" as="node()" select="$var47_CarePlan"/>
							<xsl:variable name="var35_Problem" as="node()+" select="$var36_CarePlan/*:Problems[fn:namespace-uri() eq '']/*:Problem[fn:namespace-uri() eq '']"/>
							<component>
								<section>
									<templateId>
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.2.58'"/>
									</templateId>
									<templateId>
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.2.58'"/>
										<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
									</templateId>
									<code>
										<xsl:attribute name="code" namespace="" select="'75310-3'"/>
										<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
										<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
										<xsl:attribute name="displayName" namespace="" select="'Health Concerns'"/>
									</code>
									<title>Health Concerns</title>
									<text>
										<table>
											<caption>Problems</caption>
											<thead>
												<tr>
													<th>GUID</th>
													<th>Description</th>
													<th>Start Date</th>
													<th>End Date</th>
												</tr>
											</thead>
											<tbody>
												<xsl:for-each select="$var35_Problem">
													<tr>
														<td>
															<xsl:sequence select="fn:string(@Guid)"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq ''])))"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq ''])))"/>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
										<table>
											<caption>Diagnoses</caption>
											<thead>
												<tr>
													<th>GUID</th>
													<th>Problem GUID</th>
													<th>Code</th>
													<th>Code Type</th>
													<th>Description</th>
													<th>Diagnosis Date</th>
													<th>Primary</th>
												</tr>
											</thead>
											<tbody>
												<xsl:for-each select="*:Conditions[fn:namespace-uri() eq '']/*:Diagnosis[fn:namespace-uri() eq '']">
													<tr>
														<td>
															<xsl:sequence select="fn:string(@Guid)"/>
														</td>
														<td>(Care Plan Level Diagnosis)</td>
														<xsl:for-each select="*:Code[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:CodeType[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:Description[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:DiagnosisDate[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:Primary[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="xs:string(xs:boolean(fn:string(.)))"/>
															</td>
														</xsl:for-each>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="$var35_Problem/*:Conditions[fn:namespace-uri() eq '']/*:Diagnosis[fn:namespace-uri() eq '']">
													<tr>
														<td>
															<xsl:sequence select="fn:string(@Guid)"/>
														</td>
														<xsl:for-each select="@ProblemGuid">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:Code[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:CodeType[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:Description[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="fn:string(.)"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:DiagnosisDate[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="xs:string(xs:date(fn:string(.)))"/>
															</td>
														</xsl:for-each>
														<xsl:for-each select="*:Primary[fn:namespace-uri() eq '']">
															<td>
																<xsl:sequence select="xs:string(xs:boolean(fn:string(.)))"/>
															</td>
														</xsl:for-each>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</text>
									<xsl:for-each select="$var35_Problem">
										<xsl:variable name="var33_let" as="node()+">
											<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.4'"/>
											<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
										</xsl:variable>
										<xsl:variable name="var34_Guid_as_string" as="xs:string" select="fn:string(@Guid)"/>
										<xsl:variable name="var32_let" as="node()+">
											<xsl:attribute name="code" namespace="" select="'55607006'"/>
											<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.3.88.12.3221.7.2'"/>
											<xsl:attribute name="codeSystemName" namespace="" select="'SNOMED CT'"/>
											<xsl:attribute name="displayName" namespace="" select="'Problem'"/>
											<translation>
												<xsl:attribute name="code" namespace="" select="'55607006'"/>
												<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.3.88.12.3221.7.2'"/>
												<xsl:attribute name="codeSystemName" namespace="" select="'SNOMED CT'"/>
												<xsl:attribute name="displayName" namespace="" select="'Problem'"/>
											</translation>
										</xsl:variable>
										<entry>
											<act>
												<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
												<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
												<templateId>
													<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.132'"/>
												</templateId>
												<templateId>
													<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.132'"/>
													<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
												</templateId>
												<id>
													<xsl:attribute name="root" namespace="" select="$var34_Guid_as_string"/>
												</id>
												<code>
													<xsl:attribute name="code" namespace="" select="'75310-3'"/>
													<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
													<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
													<xsl:attribute name="displayName" namespace="" select="'Health Concern Act'"/>
												</code>
												<statusCode>
													<xsl:attribute name="code" namespace="" select="'active'"/>
												</statusCode>
												<entryRelationship>
													<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
													<observation>
														<xsl:attribute name="classCode" namespace="" select="'OBS'"/>
														<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
														<templateId>
															<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.4'"/>
														</templateId>
														<templateId>
															<xsl:sequence select="$var33_let"/>
														</templateId>
														<id>
															<xsl:attribute name="extension" namespace="" select="$var34_Guid_as_string"/>
														</id>
														<code>
															<xsl:sequence select="$var32_let"/>
														</code>
														<statusCode>
															<xsl:attribute name="code" namespace="" select="'completed'"/>
														</statusCode>
														<effectiveTime>
															<low>
																<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
															</low>
															<high>
																<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
															</high>
														</effectiveTime>
														<value>
															<xsl:attribute name="xsi:type" select="xs:QName('TN')"/>
															<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
														</value>
													</observation>
												</entryRelationship>
												<xsl:for-each select="*:Conditions[fn:namespace-uri() eq '']/*:Diagnosis[fn:namespace-uri() eq '']">
													<entryRelationship>
														<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
														<encounter>
															<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
															<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
															<templateId>
																<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.80'"/>
															</templateId>
															<templateId>
																<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.80'"/>
																<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
															</templateId>
															<code>
																<xsl:attribute name="code" namespace="" select="'29308-4'"/>
																<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
																<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
																<xsl:attribute name="displayName" namespace="" select="'Diagnosis'"/>
															</code>
															<entryRelationship>
																<xsl:attribute name="typeCode" namespace="" select="'SUBJ'"/>
																<observation>
																	<xsl:attribute name="classCode" namespace="" select="'OBS'"/>
																	<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
																	<templateId>
																		<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.4'"/>
																	</templateId>
																	<templateId>
																		<xsl:sequence select="$var33_let"/>
																	</templateId>
																	<id>
																		<xsl:attribute name="extension" namespace="" select="fn:string(@Guid)"/>
																	</id>
																	<code>
																		<xsl:sequence select="$var32_let"/>
																	</code>
																	<statusCode>
																		<xsl:attribute name="code" namespace="" select="'completed'"/>
																	</statusCode>
																	<effectiveTime>
																		<low>
																			<xsl:for-each select="*:DiagnosisDate[fn:namespace-uri() eq '']">
																				<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(.))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
																			</xsl:for-each>
																		</low>
																	</effectiveTime>
																	<value>
																		<xsl:attribute name="xsi:type" select="xs:QName('CD')"/>
																		<xsl:for-each select="*:Code[fn:namespace-uri() eq '']">
																			<xsl:attribute name="code" namespace="" select="fn:string(.)"/>
																		</xsl:for-each>
																		<xsl:for-each select="*:CodeType[fn:namespace-uri() eq '']">
																			<xsl:attribute name="codeSystem" namespace="" select="fn:string(.)"/>
																		</xsl:for-each>
																		<xsl:for-each select="*:Description[fn:namespace-uri() eq '']">
																			<xsl:attribute name="displayName" namespace="" select="fn:string(.)"/>
																		</xsl:for-each>
																	</value>
																</observation>
															</entryRelationship>
														</encounter>
													</entryRelationship>
												</xsl:for-each>
												<xsl:for-each select="*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']">
													<entryRelationship>
														<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
														<act>
															<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
															<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
															<templateId>
																<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
															</templateId>
															<templateId>
																<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
																<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
															</templateId>
															<id>
																<xsl:attribute name="root" namespace="" select="fn:string(@Guid)"/>
															</id>
															<code>
																<xsl:attribute name="nullFlavor" namespace="" select="'NP'"/>
															</code>
															<statusCode>
																<xsl:attribute name="code" namespace="" select="'completed'"/>
															</statusCode>
														</act>
													</entryRelationship>
												</xsl:for-each>
											</act>
										</entry>
									</xsl:for-each>
								</section>
							</component>
							<xsl:variable name="var40_CarePlan" as="node()" select="$var47_CarePlan"/>
							<xsl:variable name="var39_Problem" as="node()+" select="$var40_CarePlan/*:Problems[fn:namespace-uri() eq '']/*:Problem[fn:namespace-uri() eq '']"/>
							<component>
								<section>
									<templateId>
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.2.60'"/>
									</templateId>
									<code>
										<xsl:attribute name="code" namespace="" select="'61146-7'"/>
										<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
										<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
										<xsl:attribute name="displayName" namespace="" select="'Goals'"/>
									</code>
									<title>Goals</title>
									<text>
										<table>
											<thead>
												<tr>
													<th>GUID</th>
													<th>Problem GUID</th>
													<th>Status</th>
													<th>Description</th>
													<th>Start Date</th>
													<th>End Date</th>
												</tr>
											</thead>
											<tbody>
												<xsl:for-each select="$var39_Problem/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']">
													<tr>
														<td>
															<xsl:sequence select="fn:string(@Guid)"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(@ProblemGuid)"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(*:Status[fn:namespace-uri() eq ''])"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq ''])))"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq ''])))"/>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</text>
									<xsl:for-each select="$var39_Problem/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']">
										<entry>
											<observation>
												<xsl:attribute name="classCode" namespace="" select="'OBS'"/>
												<xsl:attribute name="moodCode" namespace="" select="'GOL'"/>
												<templateId>
													<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.121'"/>
												</templateId>
												<id>
													<xsl:attribute name="root" namespace="" select="fn:string(@Guid)"/>
												</id>
												<code>
													<xsl:attribute name="xsi:type" select="xs:QName('CE')"/>
													<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
												</code>
												<statusCode>
													<xsl:attribute name="code" namespace="" select="fn:string(*:Status[fn:namespace-uri() eq ''])"/>
												</statusCode>
												<effectiveTime>
													<low>
														<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
													</low>
													<high>
														<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
													</high>
												</effectiveTime>
												<value>
													<xsl:attribute name="xsi:type" select="xs:QName('TN')"/>
													<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
												</value>
												<author>
													<templateId>
														<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.119'"/>
													</templateId>
													<time>
														<xsl:attribute name="value" namespace="" select="$var51_resultof_replace"/>
													</time>
													<assignedAuthor>
														<id>
															<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
														</id>
													</assignedAuthor>
												</author>
												<xsl:variable name="var37_ProblemGuid" as="node()" select="@ProblemGuid"/>
												<entryRelationship>
													<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
													<act>
														<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
														<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
														<templateId>
															<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
														</templateId>
														<id>
															<xsl:attribute name="root" namespace="" select="fn:string($var37_ProblemGuid)"/>
														</id>
														<code>
															<xsl:attribute name="nullFlavor" namespace="" select="'NP'"/>
														</code>
														<statusCode>
															<xsl:attribute name="code" namespace="" select="'completed'"/>
														</statusCode>
													</act>
												</entryRelationship>
												<xsl:for-each select="*:Interventions[fn:namespace-uri() eq '']/*:Intervention[fn:namespace-uri() eq '']">
													<xsl:variable name="var38_Guid" as="node()" select="@Guid"/>
													<entryRelationship>
														<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
														<act>
															<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
															<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
															<templateId>
																<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
															</templateId>
															<id>
																<xsl:attribute name="root" namespace="" select="fn:string($var38_Guid)"/>
															</id>
															<code>
																<xsl:attribute name="nullFlavor" namespace="" select="'NP'"/>
															</code>
															<statusCode>
																<xsl:attribute name="code" namespace="" select="'completed'"/>
															</statusCode>
														</act>
													</entryRelationship>
												</xsl:for-each>
											</observation>
										</entry>
									</xsl:for-each>
								</section>
							</component>
							<xsl:variable name="var46_CarePlan" as="node()" select="$var47_CarePlan"/>
							<xsl:variable name="var45_Problem" as="node()+" select="$var46_CarePlan/*:Problems[fn:namespace-uri() eq '']/*:Problem[fn:namespace-uri() eq '']"/>
							<component>
								<section>
									<templateId>
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.21.2.3'"/>
										<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
									</templateId>
									<code>
										<xsl:attribute name="code" namespace="" select="'62387-6'"/>
										<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.1'"/>
										<xsl:attribute name="codeSystemName" namespace="" select="'LOINC'"/>
										<xsl:attribute name="displayName" namespace="" select="'Interventions'"/>
									</code>
									<title>Interventions</title>
									<text>
										<table>
											<thead>
												<tr>
													<th>GUID</th>
													<th>Goal Guid</th>
													<th>Status</th>
													<th>Description</th>
													<th>Start Date</th>
													<th>End Date</th>
												</tr>
											</thead>
											<tbody>
												<xsl:for-each select="$var45_Problem/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']/*:Interventions[fn:namespace-uri() eq '']/*:Intervention[fn:namespace-uri() eq '']">
													<tr>
														<td>
															<xsl:sequence select="fn:string(@Guid)"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(@GoalGuid)"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(*:Status[fn:namespace-uri() eq ''])"/>
														</td>
														<td>
															<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq ''])))"/>
														</td>
														<td>
															<xsl:sequence select="xs:string(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq ''])))"/>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</text>
									<xsl:for-each select="$var45_Problem/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']/*:Interventions[fn:namespace-uri() eq '']/*:Intervention[fn:namespace-uri() eq '']">
										<xsl:variable name="var44_Status_as_string" as="xs:string" select="fn:string(*:Status[fn:namespace-uri() eq ''])"/>
										<xsl:variable name="var43_resultof_equal" as="xs:boolean" select="($var44_Status_as_string = 'completed')"/>
										<xsl:variable name="var42_test_equal" as="xs:string">
											<xsl:choose>
												<xsl:when test="$var43_resultof_equal">
													<xsl:sequence select="'2.16.840.1.113883.10.20.22.4.131'"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:sequence select="'2.16.840.1.113883.10.20.22.4.146'"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<entry>
											<act>
												<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
												<xsl:attribute name="moodCode" namespace="">
													<xsl:choose>
														<xsl:when test="$var43_resultof_equal">
															<xsl:sequence select="'EVN'"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:sequence select="'INT'"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<templateId>
													<xsl:attribute name="root" namespace="" select="$var42_test_equal"/>
												</templateId>
												<templateId>
													<xsl:attribute name="root" namespace="" select="$var42_test_equal"/>
													<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
												</templateId>
												<id>
													<xsl:attribute name="root" namespace="" select="fn:string(@Guid)"/>
												</id>
												<code>
													<xsl:attribute name="code" namespace="" select="'362956003'"/>
													<xsl:attribute name="codeSystem" namespace="" select="'2.16.840.1.113883.6.96'"/>
													<xsl:attribute name="codeSystemName" namespace="" select="'SNOMED CT'"/>
													<xsl:attribute name="displayName" namespace="" select="'Intervention'"/>
												</code>
												<text>
													<xsl:sequence select="fn:string(*:Description[fn:namespace-uri() eq ''])"/>
												</text>
												<statusCode>
													<xsl:attribute name="code" namespace="" select="$var44_Status_as_string"/>
												</statusCode>
												<effectiveTime>
													<low>
														<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
													</low>
													<high>
														<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
													</high>
												</effectiveTime>
												<xsl:variable name="var41_GoalGuid" as="node()" select="@GoalGuid"/>
												<entryRelationship>
													<xsl:attribute name="typeCode" namespace="" select="'RSON'"/>
													<act>
														<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
														<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
														<templateId>
															<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
														</templateId>
														<id>
															<xsl:attribute name="root" namespace="" select="fn:string($var41_GoalGuid)"/>
														</id>
														<code>
															<xsl:attribute name="nullFlavor" namespace="" select="'NP'"/>
														</code>
														<statusCode>
															<xsl:attribute name="code" namespace="" select="'completed'"/>
														</statusCode>
													</act>
												</entryRelationship>
											</act>
										</entry>
									</xsl:for-each>
								</section>
							</component>
						</structuredBody>
					</component>
				</xsl:for-each>
			</xsl:for-each>
		</ClinicalDocument>
	</xsl:template>
</xsl:stylesheet>