/*
Run this script on:

        (localdb)\v11.0.CSETWebTst    -  This database will be modified

to synchronize it with:

        (localdb)\v11.0.CSETWeb10120

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.4.4.16824 from Red Gate Software Ltd at 3/5/2021 8:48:49 AM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[MATURITY_QUESTIONS]'
GO
ALTER TABLE [dbo].[MATURITY_QUESTIONS] DROP CONSTRAINT [FK__MATURITY___Matur__7152C524]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_QUESTIONS] DROP CONSTRAINT [FK_MATURITY_QUESTIONS_MATURITY_QUESTIONS1]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating sequences'
GO
CREATE SEQUENCE [dbo].[MaturityNodeSequence]
AS int
START WITH 1
INCREMENT BY 1
MINVALUE -2147483648
MAXVALUE 2147483647
NO CYCLE
CACHE 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[MATURITY_MODELS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_MODELS] ADD
[Answer_Options] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[dbo].[MATURITY_MODELS].[Answer_Options_Suppressed]', N'Questions_Alias', N'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[MATURITY_QUESTIONS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_QUESTIONS] ADD
[Parent_Question_Id] [int] NULL,
[Grouping_Id] [int] NULL,
[Ranking] [int] NULL,
[Examination_Approach] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ASSESSMENT_CONTACTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ASSESSMENT_CONTACTS] ADD
[Title] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[DEMOGRAPHICS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[DEMOGRAPHICS] ADD
[OrganizationName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Agency] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrganizationType] [int] NULL,
[Facilitator] [int] NULL,
[PointOfContact] [int] NULL,
[IsScoped] [bit] NULL CONSTRAINT [DF_DEMOGRAPHICS_IsScoped] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DEMOGRAPHICS_ORGANIZATION_TYPE]'
GO
CREATE TABLE [dbo].[DEMOGRAPHICS_ORGANIZATION_TYPE]
(
[OrganizationTypeId] [int] NOT NULL,
[OrganizationType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_DEMOGRAPHICS_ORGANIZATION_TYPE] on [dbo].[DEMOGRAPHICS_ORGANIZATION_TYPE]'
GO
ALTER TABLE [dbo].[DEMOGRAPHICS_ORGANIZATION_TYPE] ADD CONSTRAINT [PK_DEMOGRAPHICS_ORGANIZATION_TYPE] PRIMARY KEY CLUSTERED  ([OrganizationTypeId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_QUESTIONS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[dbo].[FINANCIAL_QUESTIONS].[Id]', N'Maturity_Question_Id', N'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FINANCIAL_REQUIREMENTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_rename N'[dbo].[FINANCIAL_REQUIREMENTS].[ID]', N'maturity_question_id', N'COLUMN'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[NEW_REQUIREMENT]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NEW_REQUIREMENT] ADD
[Old_Id_For_Copy] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MATURITY_DOMAIN_REMARKS]'
GO
CREATE TABLE [dbo].[MATURITY_DOMAIN_REMARKS]
(
[Grouping_ID] [int] NOT NULL,
[Assessment_Id] [int] NOT NULL,
[DomainRemarks] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MATURITY_DOMAIN_REMARKS] on [dbo].[MATURITY_DOMAIN_REMARKS]'
GO
ALTER TABLE [dbo].[MATURITY_DOMAIN_REMARKS] ADD CONSTRAINT [PK_MATURITY_DOMAIN_REMARKS] PRIMARY KEY CLUSTERED  ([Grouping_ID], [Assessment_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MATURITY_GROUPINGS]'
GO
CREATE TABLE [dbo].[MATURITY_GROUPINGS]
(
[Grouping_Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Maturity_Model_Id] [int] NOT NULL,
[Sequence] [int] NOT NULL,
[Parent_Id] [int] NULL,
[Group_Level] [int] NULL,
[Type_Id] [int] NOT NULL,
[Title_Id] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_MATURITY_GROUPINGS_Unique_Node_Id] DEFAULT (NEXT VALUE FOR [MaturityNodeSequence]),
[Abbreviation] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MATURITY_ELEMENT] on [dbo].[MATURITY_GROUPINGS]'
GO
ALTER TABLE [dbo].[MATURITY_GROUPINGS] ADD CONSTRAINT [PK_MATURITY_ELEMENT] PRIMARY KEY CLUSTERED  ([Grouping_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MATURITY_GROUPING_TYPES]'
GO
CREATE TABLE [dbo].[MATURITY_GROUPING_TYPES]
(
[Type_Id] [int] NOT NULL IDENTITY(1, 1),
[Grouping_Type_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MATURITY_GROUPING_TYPES] on [dbo].[MATURITY_GROUPING_TYPES]'
GO
ALTER TABLE [dbo].[MATURITY_GROUPING_TYPES] ADD CONSTRAINT [PK_MATURITY_GROUPING_TYPES] PRIMARY KEY CLUSTERED  ([Type_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MATURITY_REFERENCE_TEXT]'
GO
CREATE TABLE [dbo].[MATURITY_REFERENCE_TEXT]
(
[Mat_Question_Id] [int] NOT NULL,
[Sequence] [int] NOT NULL,
[Reference_Text] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MATURITY_REFERENCE_TEXT] on [dbo].[MATURITY_REFERENCE_TEXT]'
GO
ALTER TABLE [dbo].[MATURITY_REFERENCE_TEXT] ADD CONSTRAINT [PK_MATURITY_REFERENCE_TEXT] PRIMARY KEY CLUSTERED  ([Mat_Question_Id], [Sequence])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FillEmptyQuestionsForAnalysis]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 7/9/2018
-- Description:	CopyData
-- =============================================
ALTER PROCEDURE [dbo].[FillEmptyQuestionsForAnalysis]
	-- Add the parameters for the stored procedure here
	@Assessment_Id int	
AS
BEGIN	
	--SET NOCOUNT ON;
	--get the list of selected standards
	--get the mode
	--for the given mode 
	--select the new_questions_sets or requirement_sets table with left join answers (possibly on the view)
	-- and do the insert
	declare @ApplicationMode varchar(100)
	declare @SALevel varchar(10)
	declare @NumRowsChanged int

	select @SALevel = ul.Universal_Sal_Level from STANDARD_SELECTION ss join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
	where @Assessment_Id = @Assessment_Id 

	DECLARE @result int;  
	exec GetApplicationModeDefault @assessment_id, @applicationmode output
	if(@ApplicationMode = 'Questions Based')
		BEGIN
			BEGIN TRANSACTION;  
		
			EXEC @result = sp_getapplock @DbPrincipal = 'dbo', @Resource = '[Answer]', @LockMode = 'Exclusive';  
				INSERT INTO [dbo].[ANSWER]  ([Question_Or_Requirement_Id], [Answer_Text], [Question_Type], [Assessment_Id])     
			select s.Question_id, Answer_Text = 'U', Question_Type='Question', Assessment_Id = @Assessment_Id
				from (select distinct s.Question_Id from NEW_QUESTION_SETS s 
					join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
					join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.new_question_set_id
					where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = @SALevel) s
				left join (select * from ANSWER where Assessment_Id = @Assessment_Id and Is_Requirement = 0) a on s.Question_Id = a.Question_Or_Requirement_Id
			where a.Question_Or_Requirement_Id is null
			IF @result = -3  
			BEGIN  
				ROLLBACK TRANSACTION;  
			END  
			ELSE  
			BEGIN  
				EXEC sp_releaseapplock @DbPrincipal = 'dbo', @Resource = '[Answer]'; 	
				COMMIT TRANSACTION;  
			END;  

			EXEC usp_BuildCatNumbers @assessment_id
		END
	else
	BEGIN
		BEGIN TRANSACTION;  		
		EXEC @result = sp_getapplock @DbPrincipal = 'dbo', @Resource = '[Answer]', @LockMode = 'Exclusive';  
		INSERT INTO [dbo].[ANSWER]  ([Question_Or_Requirement_Id], 
           [Answer_Text], [Question_Type], [Assessment_Id])     
		select distinct s.Requirement_Id, Answer_Text = 'U', Question_Type='Requirement', av.Assessment_Id 
			from requirement_sets s 
			join AVAILABLE_STANDARDS av on s.Set_Name = av.Set_Name
			join REQUIREMENT_LEVELS rl on s.Requirement_Id = rl.Requirement_Id
			left join (select * from ANSWER where Assessment_Id = @Assessment_Id and Question_Type='Requirement') a on s.Requirement_Id = a.Question_Or_Requirement_Id
		where av.Selected = 1 and av.Assessment_Id = @Assessment_Id and a.Question_Or_Requirement_Id is null and rl.Standard_Level = @SALevel and rl.Level_Type = 'NST'
			IF @result = -3  
		BEGIN  
			ROLLBACK TRANSACTION;  
		END  
		ELSE  
		BEGIN  
			EXEC sp_releaseapplock @DbPrincipal = 'dbo', @Resource = '[Answer]'; 	
			COMMIT TRANSACTION;  
		END;  
		
		EXEC usp_BuildCatNumbers @assessment_id
	END   
	
END
/****** Object:  StoredProcedure [dbo].[FillNetworkDiagramQuestions]    Script Date: 12/16/2020 11:01:45 AM ******/
SET ANSI_NULLS ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FillNetworkDiagramQuestions]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 9/27/2019
-- Description:	calll to get defaults
-- =============================================
ALTER PROCEDURE [dbo].[FillNetworkDiagramQuestions]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

	  delete a from ANSWER a 
		left join (SELECT distinct q.question_id 
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
				join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id
				join new_question_sets qs on nq.question_id=qs.question_id		
				left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where a.assessment_id = @assessment_id and qs.Set_Name = 'Components') b on a.Question_Or_Requirement_Id = b.Question_Id and a.Assessment_Id = @assessment_id
		where b.Question_Id is null and Question_Type='Component' and Assessment_Id = @assessment_id 

    /*Rules for Component questions
	For the default questions 
	select the set of component types and questions associated with the component types
	then insert an answer for each unique question in that list. 
	this needs filterd for level

	the major dimensions are 
	*/
	--generate defaults 
	INSERT INTO [dbo].[ANSWER]  ([Question_Or_Requirement_Id],[Answer_Text],[Question_Type],[Assessment_Id])   	  		
		select Question_id, Answer_Text = 'U', Question_Type='Component', Assessment_Id = @Assessment_Id 
		from (select * from [ANSWER] where [Assessment_Id] = @assessment_id and Question_Type='Component') a 		
		right join 
		(SELECT distinct q.question_id 
		FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
		join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
		join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
		join new_question nq on q.question_id=nq.question_id
		join new_question_sets qs on nq.question_id=qs.question_id		
		left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
		join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
		where a.assessment_id = @assessment_id and qs.Set_Name = 'Components'
		) t 		
		on a.Question_Or_Requirement_Id = t.question_id
		where assessment_id is null
		--and Question_Or_Requirement_Id not in 
		--(select [Question_Or_Requirement_Id] from [ANSWER] where [Assessment_Id] = @assessment_id and [Component_Guid] = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER))
END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FillEmptyMaturityQuestionsForAnalysis]'
GO
-- =============================================
-- Author:		Dylan Johnson
-- Create date: 10/04/2020
-- Description:	Create empty data for questions that have not been filled out to ensure correct reporting values
-- =============================================
ALTER PROCEDURE [dbo].[FillEmptyMaturityQuestionsForAnalysis]
	@Assessment_Id int	
AS
BEGIN	
	DECLARE @result int;  
	begin
	BEGIN TRANSACTION;  
	EXEC @result = sp_getapplock @DbPrincipal = 'dbo', @Resource = '[Answer]', @LockMode = 'Exclusive';
	INSERT INTO [dbo].[ANSWER]  ([Question_Or_Requirement_Id],[Answer_Text],[Question_Type],[Assessment_Id])     
		select mq.Mat_Question_Id,Answer_Text = 'U', Question_Type='Maturity', Assessment_Id =@Assessment_Id
		from [dbo].[MATURITY_QUESTIONS] mq
			where Maturity_Model_Id in
			(select model_id from [dbo].[AVAILABLE_MATURITY_MODELS]
			where Assessment_Id = @Assessment_Id) 
			and Mat_Question_Id not in 
			(select Question_Or_Requirement_Id from [dbo].[ANSWER] 
			where Assessment_Id = @Assessment_Id)
		IF @result = -3  
		BEGIN  
			ROLLBACK TRANSACTION;  
		END  
		ELSE  
		BEGIN  
			EXEC sp_releaseapplock @DbPrincipal = 'dbo', @Resource = '[Answer]'; 	
			COMMIT TRANSACTION;  
		END
	end

END
/****** Object:  StoredProcedure [dbo].[FillEmptyQuestionsForAnalysis]    Script Date: 12/16/2020 11:01:33 AM ******/
SET ANSI_NULLS ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_GetTop5Areas]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 1/27/2020
-- Description:	get the percentages for each area
-- line up the assessments 
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetTop5Areas]
	@Aggregation_id int
AS
BEGIN
/*
set the sequence based on assessment date
get the last two assessments.   Then compute
the percentages for all areas and take the difference
between the two assessments
once the difference is determined sort the the difference
get the top 5 for most improved and the bottom 5 for least improved.
*/
	SET NOCOUNT ON;
	exec usp_setTrendOrder @aggregation_id
    
	

	declare @assessment1 int, @assessment2 int
	set @assessment1 = null;
	set @assessment2 = null; 
	


	--declare @aggregation_id int
	--set @Aggregation_id = 2

	IF OBJECT_ID('tempdb..#answers') IS NOT NULL DROP TABLE #answers
	IF OBJECT_ID('tempdb..#TopBottomType') IS NOT NULL DROP TABLE #TopBottomType
	
	CREATE TABLE #TopBottomType(
	[Question_Group_Heading] [varchar](100) NOT NULL,
	[pdifference] [float] NULL,
	[TopBottomType] [varchar](10) NOT NULL
	)

	create table #answers (assessment_id int, answer_id int, is_requirement bit, question_or_requirement_id int, mark_for_review bit, 
	comment ntext, alternate_justification ntext, question_number int, answer_text varchar(50), 
	component_guid varchar(36), is_component bit, custom_question_guid varchar(50), is_framework bit, old_answer_id int, reviewed bit)

	declare sse cursor for select Assessment_Id from AGGREGATION_ASSESSMENT where Aggregation_Id = @Aggregation_id
	order by Sequence desc
	Declare @assessment_id int

	open sse
	fetch next from sse into @assessment_id 
	while(@@FETCH_STATUS = 0)
	begin
		if (@assessment1 is null) set @assessment1 = @assessment_id 

		insert into #answers exec [GetRelevantAnswers] @assessment_id		
		fetch next from sse into @assessment_id 
		if(@assessment2 is null ) set @assessment2 = @assessment_id
	end
	close sse 
	deallocate sse
	
	insert into #TopBottomType(Question_Group_Heading,pdifference,TopBottomType)
	select  
	 assessment1.Question_Group_Heading Question_Group_Heading,
	 assessment1.percentage-assessment2.percentage as pdifference,
	 [TopBottomType] = 'None'
	 from (
	select a.*,b.Total, (isnull(YesCount,0)+isnull(AlternateCount,0))/CAST(Total as float) as percentage  from (
	SELECT Assessment_Id, Question_Group_Heading,
			[Y] as [YesCount],			
			[N] as [NoCount],
			[NA] as [NaCount],
			[A] as [AlternateCount],
			[U] as [UnansweredCount]			
		FROM 
		(
			select Assessment_Id, h.Question_Group_Heading, Answer_Text			 
			from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
			join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			where answer_text <> 'NA'
			
		) p
		PIVOT
		(
		  count(Answer_Text)
		FOR Answer_Text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt 
		where Assessment_Id is not null) a join (
	select Assessment_Id, h.Question_Group_Heading, count(answer_text) Total 	
	from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
	join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
	where answer_text <> 'NA' and assessment_id= @assessment1
	group by  Assessment_Id, h.Question_Group_Heading) b on a.assessment_id = b.assessment_id 
	and a.Question_Group_Heading=b.Question_Group_Heading ) assessment1 join (
	
	select a.*,b.Total, (isnull(YesCount,0)+isnull(AlternateCount,0))/CAST(Total as float) as percentage  from (
	SELECT Assessment_Id, Question_Group_Heading,
			[Y] as [YesCount],			
			[N] as [NoCount],
			[NA] as [NaCount],
			[A] as [AlternateCount],
			[U] as [UnansweredCount]			
		FROM 
		(
			select Assessment_Id, h.Question_Group_Heading, Answer_Text			 
			from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
			join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			where answer_text <> 'NA'
			
		) p
		PIVOT
		(
		  count(Answer_Text)
		FOR Answer_Text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt 
		where Assessment_Id is not null) a join (
	select Assessment_Id, h.Question_Group_Heading, count(answer_text) Total 	
	from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
	join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
	where answer_text <> 'NA' and assessment_id= @assessment2
	group by  Assessment_Id, h.Question_Group_Heading) b on a.assessment_id = b.assessment_id 
	and a.Question_Group_Heading=b.Question_Group_Heading) assessment2 on assessment1.Question_Group_Heading = assessment2.Question_Group_Heading
	order by pdifference desc

	----------------------------------------------------------
	
		
	update #TopBottomType set TopBottomType = 'BOTTOM' from (
	select top 5 Question_Group_Heading from #TopBottomType order by pdifference) a
	where #TopBottomType.Question_Group_Heading = a.Question_Group_Heading

	update #TopBottomType set TopBottomType = 'TOP' from (
	select top 5 Question_Group_Heading from #TopBottomType 
	where pdifference>=0
	order by pdifference desc) a
	where #TopBottomType.Question_Group_Heading = a.Question_Group_Heading


	select a.*,b.Total, ((isnull(YesCount,0)+isnull(AlternateCount,0))/CAST(Total as float))*100 as percentage
	, #TopBottomType.pdifference, TopBottomType , Assessment_Date
	from (
	SELECT Assessment_Id, Question_Group_Heading,
			[Y] as [YesCount],			
			[N] as [NoCount],
			[NA] as [NaCount],
			[A] as [AlternateCount],
			[U] as [UnansweredCount]			
		FROM 
		(
			select Assessment_Id, h.Question_Group_Heading, Answer_Text			 
			from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
			join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			where answer_text <> 'NA'
			
		) p
		PIVOT
		(
		  count(Answer_Text)
		FOR Answer_Text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt 
		where Assessment_Id is not null) a join (
	select Assessment_Id, h.Question_Group_Heading, count(answer_text) Total 	
	from #answers a join NEW_QUESTION q on a.Question_Or_Requirement_Id = q.Question_Id
	join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
	where answer_text <> 'NA'
	group by  Assessment_Id, h.Question_Group_Heading) b 
	on a.assessment_id = b.assessment_id and a.Question_Group_Heading=b.Question_Group_Heading 
	join #TopBottomType on b.Question_Group_Heading = #TopBottomType.Question_Group_Heading
	join ASSESSMENTS on a.assessment_id = assessments.Assessment_Id
	where #TopBottomType.TopBottomType in ('Top','Bottom')
	order by TopBottomType desc, pdifference desc,Question_Group_Heading, Assessment_Date, Assessment_Id
	
	
	
		
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[AcetAnswerDistribution]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AcetAnswerDistribution]
	@Assessment_Id int,
	@targetLevel int
AS
BEGIN

	SET NOCOUNT ON;

	exec FillEmptyMaturityQuestionsForAnalysis @assessment_id

	declare @model_id int
	select @model_id = (select model_id from AVAILABLE_MATURITY_MODELS where assessment_id = @Assessment_id and selected = 1)


    select a.Answer_Text, count(*) as [Count] from maturity_questions q 
	left join answer a on a.Question_Or_Requirement_Id = q.Mat_Question_Id
	left join maturity_levels l on q.Maturity_Level = l.Maturity_Level_Id
	where a.Question_Type = 'Maturity' and q.Maturity_Model_Id = @model_id
	and l.Level <= @targetLevel
	and a.Assessment_Id = @assessment_id
	group by Answer_Text


END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetMaturityGroupings]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMaturityGroupings]
	@ModelID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   
select 
g1.grouping_id as [Group1_ID], g1.title as [Group1_Title], (select grouping_type_name from maturity_grouping_types where type_id = g1.Type_Id) as [Group1_Type], 
g2.grouping_id as [Group2_ID], g2.title as [Group2_Title], (select grouping_type_name from maturity_grouping_types where type_id = g2.Type_Id) as [Group2_Type], 
g3.grouping_id as [Group3_ID], g3.title as [Group3_Title], (select grouping_type_name from maturity_grouping_types where type_id = g3.Type_Id) as [Group3_Type], 
g4.grouping_id as [Group4_ID], g4.title as [Group4_Title], (select grouping_type_name from maturity_grouping_types where type_id = g4.Type_Id) as [Group4_Type], 
g5.grouping_id as [Group5_ID], g5.title as [Group5_Title], (select grouping_type_name from maturity_grouping_types where type_id = g5.Type_Id) as [Group5_Type] 
from maturity_groupings g1
left join maturity_groupings g2 on g2.parent_id = g1.grouping_id
left join maturity_groupings g3 on g3.parent_id = g2.grouping_id
left join maturity_groupings g4 on g4.parent_id = g3.grouping_id
left join maturity_groupings g5 on g5.parent_id = g4.grouping_id
where g1.maturity_model_id = @modelid 
and g1.Parent_Id is null
and (g2.Maturity_Model_Id = @modelid or g2.Maturity_Model_Id is null)
and (g3.Maturity_Model_Id = @modelid or g3.Maturity_Model_Id is null)
and (g4.Maturity_Model_Id = @modelid or g4.Maturity_Model_Id is null)
and (g5.Maturity_Model_Id = @modelid or g5.Maturity_Model_Id is null)
order by g1.sequence, g2.sequence, g3.sequence, g4.sequence, g5.sequence

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GetMaturityDetailsCalculations]'
GO
-- =============================================
-- Author:		CSET/ACET Team
-- Create date: 20-Jan-2021
-- Description:	Updated Calulates on maturity details
-- =============================================
CREATE PROCEDURE [dbo].[GetMaturityDetailsCalculations]
	-- Add the parameters for the stored procedure here
	@Assessment_Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	-- 'inflate' all applicable answers prior to analysis
	EXEC FillEmptyMaturityQuestionsForAnalysis @Assessment_Id


	select grouporder, 
	a.Total,
	Domain,
	AssessmentFactor,
	FinComponent,
	MaturityLevel,
	b.Answer_Text, 
	isnull(b.acount, 0) as acount,  
	isnull((cast(b.acount as float)/cast(total as float)),0) as AnswerPercent , 
	CAST(c.Complete AS BIT) AS complete 
	FROM (
			select distinct min(StmtNumber) as grouporder, fd.financialGroupId,Domain,AssessmentFactor,FinComponent,MaturityLevel,count(stmtnumber) Total 
			FROM [FINANCIAL_DETAILS] fd 
			JOIN vFinancialGroups g ON fd.financialGroupId = g.financialGroupId	
			group by fd.FinancialGroupId,Domain,AssessmentFactor,FinComponent,MaturityLevel				
			) a 
		left join (SELECT fd.FinancialGroupId, answer_text, count(a.Answer_Text) acount
			FROM    [dbo].[FINANCIAL_REQUIREMENTS] f
			INNER JOIN [dbo].[MATURITY_QUESTIONS] q ON f.[maturity_question_Id] = q.[Mat_Question_Id]
			INNER JOIN (select assessment_id, Question_Or_Requirement_Id, is_requirement, case when Answer_Text in ('Y','A','NA') then 'Y' else 'N' end as Answer_Text from [dbo].[ANSWER] where Assessment_Id = @Assessment_Id and answer_text not in ('U','N')) a ON F.[maturity_question_id] = a.[Question_Or_Requirement_Id]
			INNER JOIN [dbo].[FINANCIAL_DETAILS] AS FD ON f.[StmtNumber] = FD.[StmtNumber]   			
			WHERE [Assessment_Id] = @Assessment_Id 
			group by fd.FinancialGroupId, Answer_Text
			) b on a.FinancialGroupId = b.FinancialGroupId
		join (SELECT fd.financialGroupId, min(case answer_text when 'U' then 0 else 1 end) as Complete
			from (select * from [ANSWER] WHERE assessment_Id=@assessment_id and question_type = 'Maturity') u 
			join [dbo].[FINANCIAL_REQUIREMENTS] f ON F.[Maturity_Question_Id] = u.[Question_Or_Requirement_Id]						
			INNER JOIN [dbo].[FINANCIAL_DETAILS] AS FD ON f.[StmtNumber] = FD.[StmtNumber]   
			WHERE assessment_Id=@assessment_id 
			group by fd.financialGroupId) c on a.FinancialGroupId = c.FinancialGroupId
		order by grouporder
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_CopyIntoSet]'
GO

-- =============================================
-- Author:		Barry Hansen
-- Create date: 2/18/2021
-- Description:	copy a base set into an existing custom set
-- =============================================
CREATE PROCEDURE [dbo].[usp_CopyIntoSet]
	-- Add the parameters for the stored procedure here
	@SourceSetName varchar(50),
	@DestinationSetName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--check to make sure the destination set is a custom set
	--cannot modify existing standards
	if exists (select * from sets where Set_Name = @DestinationSetName and Is_Custom = 0)
	begin
		raiserror('Destination set is not a custom set.  Standard sets cannot be modified.',18,1);
		return 
	end

    -- Insert statements for procedure here
	insert CUSTOM_STANDARD_BASE_STANDARD (Custom_Questionaire_Name,Base_Standard) values(@DestinationSetName,@SourceSetName)
	--do the headers first
	INSERT INTO [dbo].[UNIVERSAL_SUB_CATEGORY_HEADINGS]
			   ([Sub_Heading_Question_Description]
			   ,[Question_Group_Heading_Id]
			   ,[Universal_Sub_Category_Id]
			   ,[Set_Name])
	select a.* from
	(select [Sub_Heading_Question_Description]
			   ,[Question_Group_Heading_Id]
			   ,[Universal_Sub_Category_Id]
			   ,@DestinationSetName as [Set_Name] from UNIVERSAL_SUB_CATEGORY_HEADINGS
	where Set_Name = @SourceSetName ) a 
	left join (select [Sub_Heading_Question_Description]
			   ,[Question_Group_Heading_Id]
			   ,[Universal_Sub_Category_Id]
			   ,@DestinationSetName as [Set_Name] from UNIVERSAL_SUB_CATEGORY_HEADINGS
	where Set_Name = @DestinationSetName ) b on a.Question_Group_Heading_Id=b.Question_Group_Heading_Id
	and a.Universal_Sub_Category_Id = b.Universal_Sub_Category_Id
	where b.Question_Group_Heading_Id is not null

	INSERT INTO [dbo].[NEW_REQUIREMENT]
           ([Requirement_Title]
           ,[Requirement_Text]
           ,[Supplemental_Info]
           ,[Standard_Category]
           ,[Standard_Sub_Category]
           ,[Weight]
           ,[Implementation_Recommendations]
           ,[Original_Set_Name]
           ,[NCSF_Cat_Id]
           ,[NCSF_Number]
           ,[Ranking]
           ,[Question_Group_Heading_Id]
           ,[ExaminationApproach]
           ,[Old_Id_For_Copy])
	select 		
		Requirement_Title,
		Requirement_Text,
		Supplemental_Info,
		Standard_Category,
		Standard_Sub_Category,
		Weight,
		Implementation_Recommendations,
		Original_Set_Name = @DestinationSetName,
		NCSF_Cat_Id,
		NCSF_Number,
		Ranking,
		Question_Group_Heading_Id,
		ExaminationApproach,
		r.Requirement_Id as Old_Id_For_Copy
		from REQUIREMENT_SETS s
	join NEW_REQUIREMENT r on s.Requirement_Id=r.Requirement_Id	
	where set_name = @SourceSetName
	order by Requirement_Sequence

	INSERT INTO [dbo].[REQUIREMENT_SETS]
           ([Requirement_Id]
           ,[Set_Name]
           ,[Requirement_Sequence])
	select nr.Requirement_Id,Set_name = @DestinationSetName,ns.Requirement_Sequence from NEW_REQUIREMENT nr 
	join (select s.Requirement_Id,s.Requirement_Sequence,s.Set_Name 
		from NEW_REQUIREMENT r join REQUIREMENT_SETS s on r.Requirement_Id=s.Requirement_Id 
		where s.Set_Name = @SourceSetName) ns on nr.Old_Id_For_Copy=ns.Requirement_Id
	where Original_Set_Name = @DestinationSetName

	insert into REQUIREMENT_LEVELS (Requirement_Id,Level_Type,Standard_Level)
	select a.Requirement_Id,b.Level_Type,b.Standard_Level from (
	select r.* from REQUIREMENT_SETS s join NEW_REQUIREMENT r
	on s.Requirement_Id = r.Requirement_Id
	where s.Set_Name = @DestinationSetName) a join (	
	select l.* from requirement_levels l 
	join REQUIREMENT_SETS s on l.Requirement_Id=s.Requirement_Id	
	where s.Set_Name = @SourceSetName) b on a.Old_Id_For_Copy=b.Requirement_Id


	insert into REQUIREMENT_QUESTIONS_SETS (Question_Id,Requirement_Id,Set_Name)
	select b.Question_Id,b.Requirement_Id,set_name = @DestinationSetName from REQUIREMENT_QUESTIONS_SETS a right join (
	select question_id,r.Requirement_Id
		from REQUIREMENT_QUESTIONS_SETS s
		join (select * from NEW_REQUIREMENT where Original_Set_Name= @DestinationSetName) r on s.Requirement_Id=r.Old_Id_For_Copy
		where set_name = @SourceSetName) b on a.Question_Id=b.Question_Id and a.Set_Name=@DestinationSetName
	where a.Question_Id is null

	insert REQUIREMENT_QUESTIONS (question_id,Requirement_Id)	
	select a.Question_Id,a.Requirement_Id from (
	select question_id,r.Requirement_Id
		from REQUIREMENT_QUESTIONS_SETS s
		join (select * from NEW_REQUIREMENT where Original_Set_Name= @DestinationSetName) r on s.Requirement_Id=r.Old_Id_For_Copy
		where set_name = @SourceSetName) a left join
		REQUIREMENT_QUESTIONS b on a.Question_Id=b.question_id and a.Requirement_Id=b.requirement_id
		where b.Question_Id is null
	
	INSERT INTO [dbo].[NEW_QUESTION_SETS]
           ([Set_Name]
           ,[Question_Id])    
	select a.set_name,a.Question_Id from (
	select set_name = @DestinationSetName,question_id
	from NEW_QUESTION_SETS where Set_Name = @SourceSetName) a 
	left join NEW_QUESTION_SETS b on a.Question_Id=b.Question_Id and a.set_name=b.Set_Name
	where b.Question_Id is null

	--insert the question sets records then join that with the old 
	--question sets records 		
	INSERT INTO [dbo].[NEW_QUESTION_LEVELS] ([New_Question_Set_Id],[Universal_Sal_Level])                
	select distinct b.New_Question_Set_Id,l.Universal_Sal_Level
	from NEW_QUESTION_SETS s
	join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
	join (select ss.Question_Id,ss.New_Question_Set_Id 
	from NEW_QUESTION_SETS ss
		left join NEW_QUESTION_LEVELS ls on ss.New_Question_Set_Id=ls.New_Question_Set_Id
		where set_name = @DestinationSetName and ls.New_Question_Set_Id is null) b on s.Question_Id=b.Question_Id 
	where s.Set_Name = @SourceSetName


END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_CopyIntoSet_Delete]'
GO
-- =============================================
-- Author:		Barry Hansen
-- Create date: 2/18/2021
-- Description:	Delete a copied set
-- =============================================
CREATE PROCEDURE [dbo].[usp_CopyIntoSet_Delete]
	-- Add the parameters for the stored procedure here	
	@DestinationSetName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--check to make sure the destination set is a custom set
	--cannot modify existing standards
	if exists (select * from sets where Set_Name = @DestinationSetName and Is_Custom = 0)
	begin
		raiserror('Destination set is not a custom set.  Standard sets cannot be modified.',18,1);
		return 
	end
		
	delete [dbo].[REQUIREMENT_SETS] 	where Set_Name = @DestinationSetName

	
	delete REQUIREMENT_QUESTIONS_SETS where set_name = @DestinationSetName
	--do the headers first
	delete UNIVERSAL_SUB_CATEGORY_HEADINGS where Set_Name=@DestinationSetName

	delete NEW_QUESTION_SETS where Set_Name = @DestinationSetName

	
	delete NEW_REQUIREMENT where Original_Set_Name = @destinationSetName

	-- Insert statements for procedure here
	delete CUSTOM_STANDARD_BASE_STANDARD where Custom_Questionaire_Name = @DestinationSetName	
	-- REQUIREMENT_QUESTIONS Should just cascade out
	
	
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_Assessments_For_User]'
GO


CREATE PROCEDURE [dbo].[usp_Assessments_For_User]
@User_Id int
AS

-- Replaces view Assessments_For_User.  Gathering missing alt justification is
-- more straightforward using a procedure than a view.

-- build a temp table with ALT answers without justification
select distinct assessment_id 
into #ATM
from Answer_Standards_InScope
where (isnull(alternate_justification, '') = '' and answer_text = 'A')

insert into #ATM
select distinct assessment_id 
from Answer_Maturity
where (isnull(alternate_justification, '') = '' and answer_text = 'A')

insert into #ATM
select distinct assessment_id 
from Answer_Components_InScope
where (isnull(alternate_justification, '') = '' and answer_text = 'A')


select 	
    AssessmentId = a.Assessment_Id,
	AssessmentName = Assessment_Name,
	AssessmentDate = Assessment_Date,
	AssessmentCreatedDate,
	CreatorName = u.FirstName + ' ' + u.LastName,
	LastModifiedDate = LastAccessedDate,
	MarkedForReview = isnull(mark_for_review,0),
	case when a.assessment_id in (select assessment_id from #ATM) then CAST(1 AS BIT) else CAST(0 AS BIT) END as AltTextMissing,
	c.UserId
	from ASSESSMENTS a 
		join INFORMATION i on a.Assessment_Id = i.Id
		join USERS u on a.AssessmentCreatorId = u.UserId
		join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
		left join (
			select distinct a.Assessment_Id, v.Mark_For_Review
			from ASSESSMENTS a 
			join Answer_Standards_InScope v on a.Assessment_Id = v.Assessment_Id 
			where v.Mark_For_Review = 1 

			union

			select distinct a.Assessment_Id, Mark_For_Review
			from ASSESSMENTS a
			join Answer_Maturity v on a.Assessment_id = v.Assessment_Id
			where v.Mark_For_Review = 1

			union 

			select distinct a.Assessment_Id, Mark_For_Review 
			from ASSESSMENTS a 
			join Answer_Components_InScope v on a.Assessment_Id = v.Assessment_Id 
			where v.Mark_For_Review = 1) b 
			
		on a.Assessment_Id = b.Assessment_Id
		where u.UserId = @user_id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[GLOSSARY]'
GO
CREATE TABLE [dbo].[GLOSSARY]
(
[Maturity_Model_Id] [int] NOT NULL,
[Term] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Definition] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_GLOSSARY] on [dbo].[GLOSSARY]'
GO
ALTER TABLE [dbo].[GLOSSARY] ADD CONSTRAINT [PK_GLOSSARY] PRIMARY KEY CLUSTERED  ([Maturity_Model_Id], [Term])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[DEMOGRAPHICS]'
GO
ALTER TABLE [dbo].[DEMOGRAPHICS] ADD CONSTRAINT [FK_DEMOGRAPHICS_DEMOGRAPHICS_ORGANIZATION_TYPE] FOREIGN KEY ([OrganizationType]) REFERENCES [dbo].[DEMOGRAPHICS_ORGANIZATION_TYPE] ([OrganizationTypeId])
GO
ALTER TABLE [dbo].[DEMOGRAPHICS] ADD CONSTRAINT [FK_DEMOGRAPHICS_ASSESSMENT_CONTACTS_FACILITATOR] FOREIGN KEY ([Facilitator]) REFERENCES [dbo].[ASSESSMENT_CONTACTS] ([Assessment_Contact_Id])
GO
ALTER TABLE [dbo].[DEMOGRAPHICS] ADD CONSTRAINT [FK_DEMOGRAPHICS_ASSESSMENT_CONTACTS_POINTOFCONTACT] FOREIGN KEY ([PointOfContact]) REFERENCES [dbo].[ASSESSMENT_CONTACTS] ([Assessment_Contact_Id])
GO
ALTER TABLE [dbo].[DEMOGRAPHICS] ADD CONSTRAINT [FK_DEMOGRAPHICS_DEMOGRAPHICS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[DEMOGRAPHICS] ([Assessment_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[MATURITY_DOMAIN_REMARKS]'
GO
ALTER TABLE [dbo].[MATURITY_DOMAIN_REMARKS] ADD CONSTRAINT [FK_MATURITY_DOMAIN_REMARKS_MATURITY_GROUPINGS] FOREIGN KEY ([Grouping_ID]) REFERENCES [dbo].[MATURITY_GROUPINGS] ([Grouping_Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MATURITY_DOMAIN_REMARKS] ADD CONSTRAINT [FK_MATURITY_DOMAIN_REMARKS_ASSESSMENTS] FOREIGN KEY ([Assessment_Id]) REFERENCES [dbo].[ASSESSMENTS] ([Assessment_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[MATURITY_GROUPINGS]'
GO
ALTER TABLE [dbo].[MATURITY_GROUPINGS] ADD CONSTRAINT [FK_MATURITY_GROUPINGS_MATURITY_MODELS] FOREIGN KEY ([Maturity_Model_Id]) REFERENCES [dbo].[MATURITY_MODELS] ([Maturity_Model_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[MATURITY_GROUPINGS] ADD CONSTRAINT [FK_MATURITY_GROUPINGS_MATURITY_GROUPING_TYPES] FOREIGN KEY ([Type_Id]) REFERENCES [dbo].[MATURITY_GROUPING_TYPES] ([Type_Id]) ON DELETE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[MATURITY_QUESTIONS]'
GO
ALTER TABLE [dbo].[MATURITY_QUESTIONS] ADD CONSTRAINT [FK_MATURITY_QUESTIONS_MATURITY_MODELS] FOREIGN KEY ([Maturity_Model_Id]) REFERENCES [dbo].[MATURITY_MODELS] ([Maturity_Model_Id]) ON DELETE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[MATURITY_REFERENCE_TEXT]'
GO
ALTER TABLE [dbo].[MATURITY_REFERENCE_TEXT] ADD CONSTRAINT [FK_MATURITY_REFERENCE_TEXT_MATURITY_QUESTIONS] FOREIGN KEY ([Mat_Question_Id]) REFERENCES [dbo].[MATURITY_QUESTIONS] ([Mat_Question_Id]) ON DELETE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering extended properties'
GO
BEGIN TRY
	IF NOT EXISTS (SELECT NULL FROM SYS.EXTENDED_PROPERTIES WHERE [major_id] = OBJECT_ID('AGGREGATION_TYPES') AND [name] = N'MS_Description' AND [minor_id] = 0)
		EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'AGGREGATION_TYPES', NULL, NULL
	else
		EXEC sp_updateextendedproperty N'MS_Description', N'A collection of AGGREGATION_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'AGGREGATION_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of ANSWER_LOOKUP records', 'SCHEMA', N'dbo', 'TABLE', N'ANSWER_LOOKUP', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of ASSESSMENTS records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of ASSESSMENT_SELECTED_LEVELS records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENT_SELECTED_LEVELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of AVAILABLE_STANDARDS records', 'SCHEMA', N'dbo', 'TABLE', N'AVAILABLE_STANDARDS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of CATALOG_RECOMMENDATIONS_DATA records', 'SCHEMA', N'dbo', 'TABLE', N'CATALOG_RECOMMENDATIONS_DATA', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of CATALOG_RECOMMENDATIONS_HEADINGS records', 'SCHEMA', N'dbo', 'TABLE', N'CATALOG_RECOMMENDATIONS_HEADINGS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of COMPONENT_FAMILY records', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_FAMILY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of COMPONENT_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of COMPONENT_SYMBOLS records', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of COMPONENT_SYMBOLS_GM_TO_CSET records', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_SYMBOLS_GM_TO_CSET', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of CSET_VERSION records', 'SCHEMA', N'dbo', 'TABLE', N'CSET_VERSION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of DIAGRAM_OBJECT_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_OBJECT_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of DIAGRAM_TEMPLATES records', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_TEMPLATES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of DIAGRAM_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of FILE_KEYWORDS records', 'SCHEMA', N'dbo', 'TABLE', N'FILE_KEYWORDS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of FILE_REF_KEYS records', 'SCHEMA', N'dbo', 'TABLE', N'FILE_REF_KEYS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of FILE_TYPE records', 'SCHEMA', N'dbo', 'TABLE', N'FILE_TYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of FRAMEWORK_TIERS records', 'SCHEMA', N'dbo', 'TABLE', N'FRAMEWORK_TIERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of FRAMEWORK_TIER_DEFINITIONS records', 'SCHEMA', N'dbo', 'TABLE', N'FRAMEWORK_TIER_DEFINITIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of GEN_FILE records', 'SCHEMA', N'dbo', 'TABLE', N'GEN_FILE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of GEN_FILE_LIB_PATH_CORL records', 'SCHEMA', N'dbo', 'TABLE', N'GEN_FILE_LIB_PATH_CORL', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of GEN_SAL_WEIGHTS records', 'SCHEMA', N'dbo', 'TABLE', N'GEN_SAL_WEIGHTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of GLOBAL_PROPERTIES records', 'SCHEMA', N'dbo', 'TABLE', N'GLOBAL_PROPERTIES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of INFORMATION records', 'SCHEMA', N'dbo', 'TABLE', N'INFORMATION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of LEVEL_NAMES records', 'SCHEMA', N'dbo', 'TABLE', N'LEVEL_NAMES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of MATURITY_REFERENCES records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_REFERENCES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of MATURITY_SOURCE_FILES records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_SOURCE_FILES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NCSF_CATEGORY records', 'SCHEMA', N'dbo', 'TABLE', N'NCSF_CATEGORY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NCSF_FUNCTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'NCSF_FUNCTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NEW_QUESTION records', 'SCHEMA', N'dbo', 'TABLE', N'NEW_QUESTION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NEW_QUESTION_LEVELS records', 'SCHEMA', N'dbo', 'TABLE', N'NEW_QUESTION_LEVELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NEW_QUESTION_SETS records', 'SCHEMA', N'dbo', 'TABLE', N'NEW_QUESTION_SETS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of NIST_SAL_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'NIST_SAL_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of PROCUREMENT_DEPENDENCY records', 'SCHEMA', N'dbo', 'TABLE', N'PROCUREMENT_DEPENDENCY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of PROCUREMENT_LANGUAGE_DATA records', 'SCHEMA', N'dbo', 'TABLE', N'PROCUREMENT_LANGUAGE_DATA', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of PROCUREMENT_LANGUAGE_HEADINGS records', 'SCHEMA', N'dbo', 'TABLE', N'PROCUREMENT_LANGUAGE_HEADINGS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of PROCUREMENT_REFERENCES records', 'SCHEMA', N'dbo', 'TABLE', N'PROCUREMENT_REFERENCES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of QUESTION_GROUP_HEADING records', 'SCHEMA', N'dbo', 'TABLE', N'QUESTION_GROUP_HEADING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of QUESTION_GROUP_TYPE records', 'SCHEMA', N'dbo', 'TABLE', N'QUESTION_GROUP_TYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of RECOMMENDATIONS_REFERENCES records', 'SCHEMA', N'dbo', 'TABLE', N'RECOMMENDATIONS_REFERENCES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REFERENCES_DATA records', 'SCHEMA', N'dbo', 'TABLE', N'REFERENCES_DATA', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REFERENCE_DOCS records', 'SCHEMA', N'dbo', 'TABLE', N'REFERENCE_DOCS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REF_LIBRARY_PATH records', 'SCHEMA', N'dbo', 'TABLE', N'REF_LIBRARY_PATH', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REPORT_DETAIL_SECTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'REPORT_DETAIL_SECTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REPORT_OPTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'REPORT_OPTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_LEVELS records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_LEVELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_LEVEL_TYPE records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_LEVEL_TYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_REFERENCES records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_REFERENCES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_SETS records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_SETS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of REQUIREMENT_SOURCE_FILES records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_SOURCE_FILES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of SAL_DETERMINATION_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'SAL_DETERMINATION_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of SETS records', 'SCHEMA', N'dbo', 'TABLE', N'SETS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of SETS_CATEGORY records', 'SCHEMA', N'dbo', 'TABLE', N'SETS_CATEGORY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of SHAPE_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'SHAPE_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_CATEGORY records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_CATEGORY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_CATEGORY_SEQUENCE records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_CATEGORY_SEQUENCE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_SELECTION records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_SELECTION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_SOURCE_FILE records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_SOURCE_FILE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_SPECIFIC_LEVEL records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_SPECIFIC_LEVEL', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of STANDARD_TO_UNIVERSAL_MAP records', 'SCHEMA', N'dbo', 'TABLE', N'STANDARD_TO_UNIVERSAL_MAP', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of SYMBOL_GROUPS records', 'SCHEMA', N'dbo', 'TABLE', N'SYMBOL_GROUPS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of UNIVERSAL_AREA records', 'SCHEMA', N'dbo', 'TABLE', N'UNIVERSAL_AREA', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of UNIVERSAL_SAL_LEVEL records', 'SCHEMA', N'dbo', 'TABLE', N'UNIVERSAL_SAL_LEVEL', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of UNIVERSAL_SUB_CATEGORIES records', 'SCHEMA', N'dbo', 'TABLE', N'UNIVERSAL_SUB_CATEGORIES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of VISIO_MAPPING records', 'SCHEMA', N'dbo', 'TABLE', N'VISIO_MAPPING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_updateextendedproperty N'MS_Description', N'A collection of WEIGHT records', 'SCHEMA', N'dbo', 'TABLE', N'WEIGHT', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
PRINT N'Creating extended properties'
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of AGGREGATION_INFORMATION records', 'SCHEMA', N'dbo', 'TABLE', N'AGGREGATION_INFORMATION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ANSWER records', 'SCHEMA', N'dbo', 'TABLE', N'ANSWER', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ANSWER_QUESTION_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'ANSWER_QUESTION_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of APP_CODE records', 'SCHEMA', N'dbo', 'TABLE', N'APP_CODE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ASSESSMENT_CONTACTS records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENT_CONTACTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ASSESSMENT_IRP records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENT_IRP', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ASSESSMENT_IRP_HEADER records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENT_IRP_HEADER', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of ASSESSMENT_ROLES records', 'SCHEMA', N'dbo', 'TABLE', N'ASSESSMENT_ROLES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of AVAILABLE_MATURITY_MODELS records', 'SCHEMA', N'dbo', 'TABLE', N'AVAILABLE_MATURITY_MODELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of CNSS_CIA_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'CNSS_CIA_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of COMPONENT_NAMES_LEGACY records', 'SCHEMA', N'dbo', 'TABLE', N'COMPONENT_NAMES_LEGACY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of COUNTRIES records', 'SCHEMA', N'dbo', 'TABLE', N'COUNTRIES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DEMOGRAPHICS records', 'SCHEMA', N'dbo', 'TABLE', N'DEMOGRAPHICS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DEMOGRAPHICS_ASSET_VALUES records', 'SCHEMA', N'dbo', 'TABLE', N'DEMOGRAPHICS_ASSET_VALUES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DEMOGRAPHICS_ORGANIZATION_TYPE records', 'SCHEMA', N'dbo', 'TABLE', N'DEMOGRAPHICS_ORGANIZATION_TYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DEMOGRAPHICS_SIZE records', 'SCHEMA', N'dbo', 'TABLE', N'DEMOGRAPHICS_SIZE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DIAGRAM_CONTAINER records', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_CONTAINER', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of DIAGRAM_CONTAINER_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'DIAGRAM_CONTAINER_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of EXTRA_ACET_MAPPING records', 'SCHEMA', N'dbo', 'TABLE', N'EXTRA_ACET_MAPPING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_ASSESSMENT_FACTORS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_ASSESSMENT_FACTORS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_ASSESSMENT_VALUES records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_ASSESSMENT_VALUES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_ATTRIBUTES records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_ATTRIBUTES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_COMPONENTS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_COMPONENTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_DETAILS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_DETAILS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_DOMAINS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_DOMAINS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_DOMAIN_FILTERS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_DOMAIN_FILTERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_FFIEC_MAPPINGS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_FFIEC_MAPPINGS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_GROUPS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_GROUPS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_HOURS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_HOURS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_HOURS_COMPONENT records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_HOURS_COMPONENT', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_MATURITY records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_MATURITY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_REQUIREMENTS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_REQUIREMENTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_REVIEWTYPE records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_REVIEWTYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FINANCIAL_TIERS records', 'SCHEMA', N'dbo', 'TABLE', N'FINANCIAL_TIERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FRAMEWORK_TIER_TYPE records', 'SCHEMA', N'dbo', 'TABLE', N'FRAMEWORK_TIER_TYPE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of FiltersNormalized records', 'SCHEMA', N'dbo', 'TABLE', N'FiltersNormalized', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of GENERAL_SAL_DESCRIPTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'GENERAL_SAL_DESCRIPTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of GEN_SAL_NAMES records', 'SCHEMA', N'dbo', 'TABLE', N'GEN_SAL_NAMES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of GLOSSARY records', 'SCHEMA', N'dbo', 'TABLE', N'GLOSSARY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of IMPORTANCE records', 'SCHEMA', N'dbo', 'TABLE', N'IMPORTANCE', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of INSTALLATION records', 'SCHEMA', N'dbo', 'TABLE', N'INSTALLATION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of IRP records', 'SCHEMA', N'dbo', 'TABLE', N'IRP', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of IRP_HEADER records', 'SCHEMA', N'dbo', 'TABLE', N'IRP_HEADER', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of JWT records', 'SCHEMA', N'dbo', 'TABLE', N'JWT', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of LEVEL_BACKUP_ACET records', 'SCHEMA', N'dbo', 'TABLE', N'LEVEL_BACKUP_ACET', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of LEVEL_BACKUP_ACET_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'LEVEL_BACKUP_ACET_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_DOMAIN_REMARKS records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_DOMAIN_REMARKS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_GROUPINGS records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_GROUPINGS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_GROUPING_TYPES records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_GROUPING_TYPES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_LEVELS records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_LEVELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_MODELS records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_MODELS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of MATURITY_REFERENCE_TEXT records', 'SCHEMA', N'dbo', 'TABLE', N'MATURITY_REFERENCE_TEXT', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of NERC_RISK_RANKING records', 'SCHEMA', N'dbo', 'TABLE', N'NERC_RISK_RANKING', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of NEW_REQUIREMENT records', 'SCHEMA', N'dbo', 'TABLE', N'NEW_REQUIREMENT', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of NIST_SAL_INFO_TYPES_DEFAULTS records', 'SCHEMA', N'dbo', 'TABLE', N'NIST_SAL_INFO_TYPES_DEFAULTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of PARAMETERS records', 'SCHEMA', N'dbo', 'TABLE', N'PARAMETERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of PARAMETER_REQUIREMENTS records', 'SCHEMA', N'dbo', 'TABLE', N'PARAMETER_REQUIREMENTS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of REQUIRED_DOCUMENTATION records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIRED_DOCUMENTATION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of REQUIRED_DOCUMENTATION_HEADERS records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIRED_DOCUMENTATION_HEADERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of REQUIREMENT_QUESTIONS_SETS records', 'SCHEMA', N'dbo', 'TABLE', N'REQUIREMENT_QUESTIONS_SETS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SECTOR records', 'SCHEMA', N'dbo', 'TABLE', N'SECTOR', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SECTOR_INDUSTRY records', 'SCHEMA', N'dbo', 'TABLE', N'SECTOR_INDUSTRY', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SECTOR_STANDARD_RECOMMENDATIONS records', 'SCHEMA', N'dbo', 'TABLE', N'SECTOR_STANDARD_RECOMMENDATIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SECURITY_QUESTION records', 'SCHEMA', N'dbo', 'TABLE', N'SECURITY_QUESTION', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SET_FILES records', 'SCHEMA', N'dbo', 'TABLE', N'SET_FILES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of SP80053_FAMILY_ABBREVIATIONS records', 'SCHEMA', N'dbo', 'TABLE', N'SP80053_FAMILY_ABBREVIATIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of STATES_AND_PROVINCES records', 'SCHEMA', N'dbo', 'TABLE', N'STATES_AND_PROVINCES', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of UNIVERSAL_SUB_CATEGORY_HEADINGS records', 'SCHEMA', N'dbo', 'TABLE', N'UNIVERSAL_SUB_CATEGORY_HEADINGS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of USERS records', 'SCHEMA', N'dbo', 'TABLE', N'USERS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
BEGIN TRY
	EXEC sp_addextendedproperty N'MS_Description', N'A collection of USER_SECURITY_QUESTIONS records', 'SCHEMA', N'dbo', 'TABLE', N'USER_SECURITY_QUESTIONS', NULL, NULL
END TRY
BEGIN CATCH
	DECLARE @msg nvarchar(max);
	DECLARE @severity int;
	DECLARE @state int;
	SELECT @msg = ERROR_MESSAGE(), @severity = ERROR_SEVERITY(), @state = ERROR_STATE();
	RAISERROR(@msg, @severity, @state);

	SET NOEXEC ON
END CATCH
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
