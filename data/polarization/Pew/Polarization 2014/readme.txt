PEW RESEARCH CENTER FOR THE PEOPLE & THE PRESS
POLITICAL TYPOLOGY/POLARIZATION
Phase A: January 23-February 9, 2014 N=3,341
Phase B: February 12-26, 2014 N=3,337
Phase C: February 27-March 16, 2014 N=3,335
Total N=10, 013


***************************************************************************************************************************

This dataset includes cell phone interviews conducted using an RDD sample of cell phone numbers. 
Cell phone interviews include households that are cell-only as well as those that also have a landline phone. 
The dataset contains several weight variables. 

WEIGHT is the weight for the combined sample of all landline and cell phone interviews. 
Data for all Pew Research Center reports are analyzed using this weight.

Two other weights can be used to compare the combined sample with the landline sample by itself 
and with the landline sample combined with the cell-only households.

LLWEIGHT is for analysis of the landline RDD sample only. Interviews conducted by cellphone are not 
given a weight and are excluded from analysis when this weight is used.

COWEIGHT is for analysis of the combined landline RDD sample and the cell-only cases. 
Cases from the cell phone RDD sample that reported having a landline phone are not given 
a weight and are excluded from analysis when this weight is used.

***************************************************************************************************************************

Beginning in the Fall of 2008, the Pew Research Center started using respondents’ self-reported zip code as  
the basis for geographic variables such as region, state and county. We do this because the error rate in the original 
geographic information associated with the sample is quite high, especially for respondents from the cell phone sample. 

For respondents who do not provide a zip code or for those we cannot match, we use the sample geographic information. 
We continue to include the original sample geographic variables in the datasets (these variables are preceded by an ‘s’) 
for archival purposes only.

To protect the privacy of respondents, telephone numbers, county of residence and zip code have been removed from the data file.

***************************************************************************************************************************

Releases from this survey:

March 7, 2014 "Millennials in Adulthood: Detached from Institutions, Networked with Friends"
http://www.pewsocialtrends.org/2014/03/07/millennials-in-adulthood/

March 19, 2014 "Keystone XL Pipeline Divides Democrats: Proposal Retains 2-to-1 Support among Public"
http://www.people-press.org/2014/03/19/keystone-xl-pipeline-divides-democrats/

March 20, 2014 "ACA at Age 4: More Disapproval than Approval: But Most Oppents Want Politicians to Make Law Work"
http://www.people-press.org/2014/03/20/aca-at-age-4-more-disapproval-than-approval/

April 2, 2014 "America's New Drug Policy Landscape: Two-Thirds Favor Treatment, Not Jail for Use of Heroin, Cocaine"
http://www.people-press.org/2014/04/02/americas-new-drug-policy-landscape/

June 12, 2014 "Political Polarization in the American Public"
http://www.people-press.org/2014/06/12/political-polarization-in-the-american-public/

June 26, 2014 "Beyond Red vs. Blue: The Political Typology"
http://www.people-press.org/2014/06/26/the-political-typology-beyond-red-vs-blue/


*********

MEASURES OF ENGAGEMENT:
The variable active2 was used to assess political engagment in the 2014 data.
recode q101 (1=1) (else=0) into contribute2.
recode q105a (1=1) (else=0) into volunteer.
compute active=0.
if (contribute2=1 or volunteer=1) active=1. 
var label active 'Donated money or volunteered in past two years'.
val label active 0 'Not donated or volunteered' 1 'Donated or volunteered'.
compute active2=0.
if ((reg=1 and oftvote<3) and active=0) active2=1.
if ((reg=1 and oftvote<3) and active=1) active2=2.
var label active2 'Donated or volunteered by voter and non-voter'.
val label active2 0 'Not registered or infrequent voter' 1 'Registered and nearly always vote, but not active' 2 'Registered and nearly always vote, active'.

This simplified engagement measure was used to assess engagement over time.
compute engaged = 0.
if (reg eq 1 or regicert eq 1) and (oftvote eq 1 or oftvote eq 2) and (folgov eq 1) engaged = 1.
Variable label engaged 1 'Engaged' 0 'Not engaged'.


IDEOLOGICAL CONSISTENCY AND TYPOLOGY:


**create items for use in ideological consistency scale and typology**.
***these are the ideological consistency scale items (also used in typo)**.
compute GovWaste2 = q25a.
compute Regulate2 = q25b.
compute PoorEasy2 = q25c.
compute GovNeedy2 = q25d.
compute Discrimi2 = q25f.
compute ImmBurdn2 = q25g.
compute PeaceStr2 = q25i.
compute BusProft2 = q25n.
compute LawsCost2 = q50r.
compute Homosex2 = q50u.

**these items are not a part of the ideo consistency scale, but ARE a part of the typology***.
compute Govaid2=q51kk.
compute BlackEq2=q50hh.
compute WorkHard2 = q25k.
compute Success2 = q25l.
compute ImmCult2=q50dd.
compute BusPower2 = q25m.
compute ProtEnv2 = q50q.
compute ForcTerr2=q50bb.
compute Active2 =q50ee.
compute USworse2=q25j.
compute CivLib2 =Q50ff.
compute Marrichild2=q25h.
compute NeccGod2=q50aa.

**NOTE THESE VARIABLES ARE NOT USED IN EITHER THE IDEOLOGICAL CONSISTENCY SCALE OR THE TYPOLOGY, BUT COULD ALSO BE CONSIDERED FOR TYPOLOGY. 
NOTE THAT SOME OF THESE ARE ASKED ONLY IN ONE PHASE OF THE STUDY**.
**If these are used in the future, be sure to make adjustments to the directionality for L-C (that syntax is not included here)**.
*compute SatFin2 = q50y.
*compute MakeEnds2 = q50z.
*compute ReligImp2=q50w.
*compute Govmoreless2=q51ii.
*compute Childpar2=q51jj.
*compute Compro2=q51mm.
*compute Effortcirc2=q53.
*compute Econsys2=q51ll.
*compute LoseTch2 = q25o.
*compute OffCare2 = q25p.
*compute NoLimits2 = q50s.
*compute USAsolve2 = q50t.
*compute GovMoral2 =q50gg.
*COMPUTE police2=Q51OO.
*compute protmor2=q50gg.
*compute protpeopl2=q50v.


***HERE WE RECODE THE FORCED CHOICE QUESTIONS with DK/Neither centered***.
recode GovWaste2 to neccgod2 (1=-1) (3,5,9=0) (2=1).
value labels GovWaste2 to neccgod2 -1 'statement 1' 0 "Both/DK/Refused" 1 'statement 2'.

**recoding to put liberal response on the left, conservative on the right*.
recode GovWaste2 (1=-1) (-1=1).
val lab govwaste2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode marrichild2  (1=-1) (-1=1).
val lab marrichild2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode lawscost2 (1=-1) (-1=1).
val lab lawscost2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode ImmCult2 (1=-1) (-1=1).
val lab immcult2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode blackeq2 (1=-1) (-1=1).
val lab blackeq2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode POOREASY2 GOVAID2 (1=-1) (-1=1).
val lab pooreasy2 govaid2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode ForcTerr2 PeaceStr2 (1=-1) (-1=1).
val lab forcterr2 peacestr2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode WorkHard2 (1=-1) (-1=1).
val lab workhard2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

**CODED WITH ACTIVISM ON THE RIGHT, ISOLATIONISM ON THE LEFT**.
recode active2 (1=-1) (-1=1).
val lab active2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

recode civlib2 (1=-1) (-1=1).
val lab civlib2 -1 'statement 2' 0 "Both/DK/Refused" 1 'statement 1'.

**** IDEOLOGICAL CONSISTENCY SCALE ****.
count consCount10 = GovWaste2 Regulate2 PoorEasy2 GovNeedy2 Discrimi2 ImmBurdn2 PeaceStr2 BusProft2 LawsCost2 Homosex2(1).
count libCount10 = GovWaste2 Regulate2 PoorEasy2 GovNeedy2 Discrimi2 ImmBurdn2 PeaceStr2 BusProft2 LawsCost2 Homosex2(-1).
compute ideoconsist = consCount10 - libCount10.

*Syntax to recode ideological consistency scale into 5 categories.
recode ideoConsist (-10 thru -7=1)(-6 thru - 3=2)(-2 thru 2 =3)(3 thru 6=4)(7 thru 10=5) into ideoConsistREC.
val lab ideoConsistREC 1'Consistent Lib' 2'Lean Lib' 3'Inconsistent' 4'Lean Cons' 5'Consistent Cons'.
var lab ideoConsistREC 'Ideological consistency scale recoded into 5 categories'.
cross ideoConsist by ideoConsistREC. 



***THE 2014 POLITICAL TYPOLOGY*** 


* WARNING: The 2014 Political Typology was created using cluster analysis, and the following syntax shows the basic steps used to construct it. 
IF YOU ARE SEEKING TO REPLICATE THESE ANALYSES, PLEASE CONTACT US FOR ADDITIONAL SYNTAX.
Cluster analysis is not an exact process, with different solutions possible using the same data depending on model specifications and 
even the order in which respondents are sorted. In order to address the sensitivity of cluster analysis to the order in which cases are entered, each
cluster model was run several thousand times, and the results compared, to identify the solution that produced the set of groups that were both 
homogeneous internally and different from one another with respect to the set of political values. In technical terms, the solution for each model
with the lowest sum of squared error of the clusters was chosen. Models with different numbers of clusters were examined, and the results evaluated 
for their effectiveness in producing cohesive groups that were sufficiently distinct from one another, large enough in size to be analytically
practical and substantively meaningful. 


****IF YOU ARE SEEKING TO REPLICATE THE PEW RESEARCH CENTER 2014 TYPOLOGY WITH THIS DATA, IMPORTANT NOTE: This precise cluster analysis run is based on a dataset that 
inadvertently included a duplicate case, which was later removed. As a result of the sensitivities of cluster analysis, this syntax will not result in the same clusters 
unless the dataset with the duplicate case is used, if you are seeking to replicate the exact cluster analysis on the 2014 Pew Research Center data, 
please contact us for that dataset.

**IF YOU ARE SEEKING TO RECREATE THE TYPOLOGY USING A DIFFERENT DATASET: You will almost certainly end up with different groups that may or may not fit the same descriptions.
  The only way to replicate the same groups in the this typology is to use a different statistical procedure, which we can make available.


**TYPOLOGY CONSTRUCTION***.
**WE CREATE A GROUP OF UNENGAGED PEOPLE (BYSTANDERS), WHICH WE EXCLUDE FROM OUR TYPOLOGY CONSTRUCTION. THE DEFINITION HAS SHIFTED SLIGHTLY FROM YEAR TO YEAR
BUT IT IS LIKELY WE WILL CONTINUE TO USE THIS DEFINITION*.
****CREATE BYSTANDER GROUP*****.
**DEFINITION OF BYSTANDERS - NOT REGISTERED TO VOTE, SELDOM OR NEVER VOTE AND DO NOT FOLLOW GOVERNMENT AND PUBLIC AFFAIRS MOST OF THE TIME**. 
compute bys=0.
if ((reg>2) and (oftvote=4 or oftvote=5) and (q40>1)) bys=1.
format bys (F1.0).


***the following cluster model (as well as other models) was run on 5000 runs, saving out the seeds. Sort the seeds by lowest SSE, identifying the "Best" model. 
Use that seed for the final model*
*weight by weight.
*temp.
*select if bys=0.
*quick cluster GovWaste2 Regulate2 PoorEasy2 GovNeedy2 Govaid2 Discrimi2 blackeq2 WorkHard2 Success2 ImmBurdn2 ImmCult2 
 BusPower2 BusProft2 ProtEnv2 LawsCost2 PeaceStr2 ForcTerr2 Active2 USworse2 CivLibin  Homosex2 Marrichild2 NeccGod2 
 /method=kmeans(noupdate) 
 /missing=listwise  /criteria=  mxiter(999) clust(7) 
 /save cluster (typoA7).


**NOTE, q50FF was not asked on the first few nights of the survey. Some responses were captured on a follow-up survey, others were imputed. 
These respondents were then assigned a typology group based on their distances to the cluster centers. Additional syntax detailing this is available upon request.**.


**party strength***.
Party strength was added a few nights into the field period. As a result, to recreate topline results for party and party strength for that question, run the following syntax, 
which brings in the data from the breakoffs who did get the question.
weight by weight.
temp.
select if partystrflag=1.
fre party partystr.

