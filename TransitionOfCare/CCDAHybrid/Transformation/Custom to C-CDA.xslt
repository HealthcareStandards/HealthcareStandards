<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xs fn">
	<xsl:output method="xml" encoding="UTF-8" byte-order-mark="no" indent="yes"/>
	<xsl:template match="/">
		<ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
			<xsl:attribute name="xsi:schemaLocation" select="'urn:hl7-org:v3 CDA_SDTC.xsd'"/>
			<xsl:for-each select="*:TransitionOfCare[fn:namespace-uri() eq '']">
				<xsl:variable name="var45_resultof_replace" as="xs:string" select="replace(format-dateTime(fn:current-dateTime(), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
				<xsl:variable name="var44_Author" as="node()" select="*:Author[fn:namespace-uri() eq '']"/>
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
					<xsl:attribute name="value" namespace="" select="$var45_resultof_replace"/>
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
				<xsl:variable name="var9_Author" as="node()" select="$var44_Author"/>
				<xsl:variable name="var8_Address" as="node()" select="$var9_Author/*:Address[fn:namespace-uri() eq '']"/>
				<xsl:variable name="var7_Name_as_string" as="xs:string" select="fn:string($var9_Author/*:Name[fn:namespace-uri() eq ''])"/>
				<author>
					<time>
						<xsl:attribute name="value" namespace="" select="$var45_resultof_replace"/>
					</time>
					<assignedAuthor>
						<id>
							<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
							<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.4.6'"/>
						</id>
						<addr>
							<state>
								<xsl:sequence select="fn:string($var8_Address/*:State[fn:namespace-uri() eq ''])"/>
							</state>
							<city>
								<xsl:sequence select="fn:string($var8_Address/*:City[fn:namespace-uri() eq ''])"/>
							</city>
							<postalCode>
								<xsl:sequence select="fn:string($var8_Address/*:ZipCode[fn:namespace-uri() eq ''])"/>
							</postalCode>
							<streetAddressLine>
								<xsl:sequence select="fn:string($var8_Address/*:AddressLine[fn:namespace-uri() eq ''])"/>
							</streetAddressLine>
						</addr>
						<telecom>
							<xsl:variable name="var3_PhoneExtension" as="node()" select="$var9_Author/*:PhoneExtension[fn:namespace-uri() eq '']"/>
							<xsl:variable name="var4_result" as="xs:string?">
								<xsl:if test="fn:not((fn:translate(fn:string($var3_PhoneExtension/@xsi:nil), 'true ', '1') = '1'))">
									<xsl:sequence select="fn:string($var3_PhoneExtension)"/>
								</xsl:if>
							</xsl:variable>
							<xsl:for-each select="$var4_result">
								<xsl:variable name="var6_Phone_as_string" as="xs:string" select="fn:string($var9_Author/*:Phone[fn:namespace-uri() eq ''])"/>
								<xsl:variable name="var5_test_resultof_equal" as="xs:string">
									<xsl:choose>
										<xsl:when test="(. = '')">
											<xsl:sequence select="$var6_Phone_as_string"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:sequence select="fn:concat(fn:concat($var6_Phone_as_string, ' '), .)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI($var5_test_resultof_equal))"/>
							</xsl:for-each>
							<xsl:attribute name="use" namespace="" select="'WP'"/>
						</telecom>
						<assignedAuthoringDevice>
							<manufacturerModelName>
								<xsl:sequence select="$var7_Name_as_string"/>
							</manufacturerModelName>
							<softwareName>
								<xsl:sequence select="$var7_Name_as_string"/>
							</softwareName>
						</assignedAuthoringDevice>
					</assignedAuthor>
				</author>
				<xsl:variable name="var15_Author" as="node()" select="$var44_Author"/>
				<xsl:variable name="var14_Address" as="node()" select="$var15_Author/*:Address[fn:namespace-uri() eq '']"/>
				<custodian>
					<assignedCustodian>
						<representedCustodianOrganization>
							<id>
								<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
								<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.4.6'"/>
							</id>
							<name>
								<xsl:sequence select="fn:string($var15_Author/*:Name[fn:namespace-uri() eq ''])"/>
							</name>
							<telecom>
								<xsl:variable name="var10_PhoneExtension" as="node()" select="$var15_Author/*:PhoneExtension[fn:namespace-uri() eq '']"/>
								<xsl:variable name="var11_result" as="xs:string?">
									<xsl:if test="fn:not((fn:translate(fn:string($var10_PhoneExtension/@xsi:nil), 'true ', '1') = '1'))">
										<xsl:sequence select="fn:string($var10_PhoneExtension)"/>
									</xsl:if>
								</xsl:variable>
								<xsl:for-each select="$var11_result">
									<xsl:variable name="var13_Phone_as_string" as="xs:string" select="fn:string($var15_Author/*:Phone[fn:namespace-uri() eq ''])"/>
									<xsl:variable name="var12_test_resultof_equal" as="xs:string">
										<xsl:choose>
											<xsl:when test="(. = '')">
												<xsl:sequence select="$var13_Phone_as_string"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:sequence select="fn:concat(fn:concat($var13_Phone_as_string, ' '), .)"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI($var12_test_resultof_equal))"/>
								</xsl:for-each>
								<xsl:attribute name="use" namespace="" select="'WP'"/>
							</telecom>
							<addr>
								<state>
									<xsl:sequence select="fn:string($var14_Address/*:State[fn:namespace-uri() eq ''])"/>
								</state>
								<city>
									<xsl:sequence select="fn:string($var14_Address/*:City[fn:namespace-uri() eq ''])"/>
								</city>
								<postalCode>
									<xsl:sequence select="fn:string($var14_Address/*:ZipCode[fn:namespace-uri() eq ''])"/>
								</postalCode>
								<streetAddressLine>
									<xsl:sequence select="fn:string($var14_Address/*:AddressLine[fn:namespace-uri() eq ''])"/>
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
								<xsl:attribute name="value" namespace="" select="$var45_resultof_replace"/>
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
				<xsl:variable name="var43_CaseManagement" as="node()" select="*:CaseManagement[fn:namespace-uri() eq '']"/>
				<xsl:variable name="var41_CaseManager" as="node()" select="$var43_CaseManagement/*:CaseManager[fn:namespace-uri() eq '']"/>
				<xsl:variable name="var42_CarePlan" as="node()" select="$var43_CaseManagement/*:CarePlan[fn:namespace-uri() eq '']"/>
				<component>
					<structuredBody>
						<xsl:variable name="var20_CarePlan" as="node()" select="$var42_CarePlan"/>
						<xsl:variable name="var19_Problems" as="node()?" select="$var20_CarePlan/*:Problems[fn:namespace-uri() eq '']"/>
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
										<thead>
											<tr>
												<th>GUID</th>
												<th>Description</th>
												<th>Start Date</th>
												<th>End Date</th>
											</tr>
										</thead>
										<tbody>
											<xsl:for-each select="$var19_Problems/*:Problem[fn:namespace-uri() eq '']">
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
								</text>
								<xsl:for-each select="$var19_Problems/*:Problem[fn:namespace-uri() eq '']">
									<xsl:variable name="var17_let" as="node()+">
										<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.4'"/>
										<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
									</xsl:variable>
									<xsl:variable name="var18_Guid_as_string" as="xs:string" select="fn:string(@Guid)"/>
									<xsl:variable name="var16_let" as="node()+">
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
												<xsl:attribute name="extension" namespace="" select="$var18_Guid_as_string"/>
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
														<xsl:sequence select="$var17_let"/>
													</templateId>
													<id>
														<xsl:attribute name="extension" namespace="" select="$var18_Guid_as_string"/>
													</id>
													<code>
														<xsl:sequence select="$var16_let"/>
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
																	<xsl:sequence select="$var17_let"/>
																</templateId>
																<id>
																	<xsl:attribute name="extension" namespace="" select="fn:string(@Guid)"/>
																</id>
																<code>
																	<xsl:sequence select="$var16_let"/>
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
						<xsl:variable name="var24_CarePlan" as="node()" select="$var42_CarePlan"/>
						<xsl:variable name="var23_Problems" as="node()?" select="$var24_CarePlan/*:Problems[fn:namespace-uri() eq '']"/>
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
											<xsl:for-each select="$var23_Problems/*:Problem[fn:namespace-uri() eq '']/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']">
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
								<xsl:for-each select="$var23_Problems/*:Problem[fn:namespace-uri() eq '']/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']">
									<entry>
										<observation>
											<xsl:attribute name="classCode" namespace="" select="'OBS'"/>
											<xsl:attribute name="moodCode" namespace="" select="'GOL'"/>
											<templateId>
												<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.121'"/>
											</templateId>
											<id>
												<xsl:attribute name="extension" namespace="" select="fn:string(@Guid)"/>
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
													<xsl:attribute name="value" namespace="" select="$var45_resultof_replace"/>
												</time>
												<assignedAuthor>
													<id>
														<xsl:attribute name="nullFlavor" namespace="" select="'UNK'"/>
													</id>
												</assignedAuthor>
											</author>
											<xsl:variable name="var21_ProblemGuid" as="node()" select="@ProblemGuid"/>
											<entryRelationship>
												<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
												<act>
													<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
													<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
													<templateId>
														<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
													</templateId>
													<id>
														<xsl:attribute name="root" namespace="" select="fn:string($var21_ProblemGuid)"/>
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
												<xsl:variable name="var22_Guid" as="node()" select="@Guid"/>
												<entryRelationship>
													<xsl:attribute name="typeCode" namespace="" select="'REFR'"/>
													<act>
														<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
														<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
														<templateId>
															<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
														</templateId>
														<id>
															<xsl:attribute name="root" namespace="" select="fn:string($var22_Guid)"/>
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
						<xsl:variable name="var30_CarePlan" as="node()" select="$var42_CarePlan"/>
						<xsl:variable name="var29_Problems" as="node()?" select="$var30_CarePlan/*:Problems[fn:namespace-uri() eq '']"/>
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
											<xsl:for-each select="$var29_Problems/*:Problem[fn:namespace-uri() eq '']/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']/*:Interventions[fn:namespace-uri() eq '']/*:Intervention[fn:namespace-uri() eq '']">
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
								<xsl:for-each select="$var29_Problems/*:Problem[fn:namespace-uri() eq '']/*:Goals[fn:namespace-uri() eq '']/*:Goal[fn:namespace-uri() eq '']/*:Interventions[fn:namespace-uri() eq '']/*:Intervention[fn:namespace-uri() eq '']">
									<xsl:variable name="var28_Status_as_string" as="xs:string" select="fn:string(*:Status[fn:namespace-uri() eq ''])"/>
									<xsl:variable name="var27_resultof_equal" as="xs:boolean" select="($var28_Status_as_string = 'completed')"/>
									<xsl:variable name="var26_test_equal" as="xs:string">
										<xsl:choose>
											<xsl:when test="$var27_resultof_equal">
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
													<xsl:when test="$var27_resultof_equal">
														<xsl:sequence select="'EVN'"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:sequence select="'INT'"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											<templateId>
												<xsl:attribute name="root" namespace="" select="$var26_test_equal"/>
											</templateId>
											<templateId>
												<xsl:attribute name="root" namespace="" select="$var26_test_equal"/>
												<xsl:attribute name="extension" namespace="" select="'2015-08-01'"/>
											</templateId>
											<id>
												<xsl:attribute name="extension" namespace="" select="fn:string(@Guid)"/>
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
												<xsl:attribute name="code" namespace="" select="$var28_Status_as_string"/>
											</statusCode>
											<effectiveTime>
												<low>
													<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:StartDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
												</low>
												<high>
													<xsl:attribute name="value" namespace="" select="replace(format-dateTime(xs:dateTime(xs:date(fn:string(*:EndDate[fn:namespace-uri() eq '']))), '[Y][M,2][D,2][H,2][m][s][Z]'), ':', '')"/>
												</high>
											</effectiveTime>
											<xsl:variable name="var25_GoalGuid" as="node()" select="@GoalGuid"/>
											<entryRelationship>
												<xsl:attribute name="typeCode" namespace="" select="'RSON'"/>
												<act>
													<xsl:attribute name="classCode" namespace="" select="'ACT'"/>
													<xsl:attribute name="moodCode" namespace="" select="'EVN'"/>
													<templateId>
														<xsl:attribute name="root" namespace="" select="'2.16.840.1.113883.10.20.22.4.122'"/>
													</templateId>
													<id>
														<xsl:attribute name="root" namespace="" select="fn:string($var25_GoalGuid)"/>
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
									<paragraph>
										<xsl:sequence select="'Additional Care Plan Information'"/>
										<br></br>
									</paragraph>
									<table>
										<thead>
											<tr>
												<th>Name</th>
												<th>Value</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>Programe Type</td>
												<td>
													<xsl:sequence select="fn:string($var43_CaseManagement/*:ProgramType[fn:namespace-uri() eq ''])"/>
												</td>
											</tr>
											<tr>
												<td>Program</td>
												<td>
													<xsl:sequence select="fn:string($var43_CaseManagement/*:Program[fn:namespace-uri() eq ''])"/>
												</td>
											</tr>
											<tr>
												<td>Case Manager Name</td>
												<xsl:variable name="var31_CaseManager" as="node()" select="$var41_CaseManager"/>
												<td>
													<xsl:sequence select="fn:concat(fn:concat(fn:string($var31_CaseManager/*:FirstName[fn:namespace-uri() eq '']), ' '), fn:string($var31_CaseManager/*:LastName[fn:namespace-uri() eq '']))"/>
												</td>
											</tr>
											<tr>
												<td>Case Manager Phone</td>
												<xsl:variable name="var35_CaseManager" as="node()" select="$var41_CaseManager"/>
												<xsl:variable name="var32_PhoneExtension" as="node()" select="$var35_CaseManager/*:PhoneExtension[fn:namespace-uri() eq '']"/>
												<xsl:variable name="var33_result" as="xs:string?">
													<xsl:if test="fn:not((fn:translate(fn:string($var32_PhoneExtension/@xsi:nil), 'true ', '1') = '1'))">
														<xsl:sequence select="fn:string($var32_PhoneExtension)"/>
													</xsl:if>
												</xsl:variable>
												<xsl:for-each select="$var33_result">
													<xsl:variable name="var34_Phone_as_string" as="xs:string" select="fn:string($var35_CaseManager/*:Phone[fn:namespace-uri() eq ''])"/>
													<td>
														<xsl:choose>
															<xsl:when test="(. = '')">
																<xsl:sequence select="$var34_Phone_as_string"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:sequence select="fn:concat(fn:concat($var34_Phone_as_string, ' '), .)"/>
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</xsl:for-each>
											</tr>
											<xsl:for-each select="*:Conditions[fn:namespace-uri() eq '']/*:Diagnosis[fn:namespace-uri() eq '']">
												<xsl:variable name="var40_cur" as="node()" select="."/>
												<tr>
													<td>Case Diagnosis</td>
													<xsl:for-each select="*:CodeType[fn:namespace-uri() eq '']">
														<xsl:variable name="var39_Address" as="node()" select="."/>
														<xsl:for-each select="$var40_cur/*:Code[fn:namespace-uri() eq '']">
															<xsl:variable name="var38_cur" as="node()" select="."/>
															<xsl:for-each select="$var40_cur/*:Description[fn:namespace-uri() eq '']">
																<xsl:variable name="var37_cur" as="node()" select="."/>
																<xsl:for-each select="$var40_cur/*:DiagnosisDate[fn:namespace-uri() eq '']">
																	<xsl:variable name="var36_cur" as="node()" select="."/>
																	<xsl:for-each select="$var40_cur/*:Primary[fn:namespace-uri() eq '']">
																		<td>
																			<xsl:sequence select="fn:concat(fn:concat(fn:concat(fn:concat(fn:concat(fn:concat(fn:concat(fn:concat(fn:concat(fn:string($var39_Address), ' -- '), fn:string($var38_cur)), ' -- '), fn:string($var37_cur)), ' -- '), xs:string(xs:date(fn:string($var36_cur)))), ' -- '), 'Primary: '), xs:string(xs:boolean(fn:string(.))))"/>
																		</td>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
									<xsl:comment select="'Internal Transition of Care v3 Contents'"/>
								</text>
							</section>
						</component>
					</structuredBody>
				</component>
			</xsl:for-each>
		</ClinicalDocument>
	</xsl:template>
</xsl:stylesheet>
