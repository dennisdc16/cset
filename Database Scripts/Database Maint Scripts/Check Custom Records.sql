WITH AllCustomRowCounts AS
(
	SELECT COUNT(*) AS RowCnt FROM [NEW_REQUIREMENT] WHERE [Requirement_Id] >= 1000000
	UNION ALL
	SELECT COUNT(*) FROM [NEW_QUESTION] WHERE [Question_Id] >= 1000000
	UNION ALL
	SELECT COUNT(*) FROM [NEW_QUESTION_SETS] WHERE [New_Question_Set_Id] >= 1000000 OR [Question_Id] >= 1000000
	UNION ALL
	SELECT COUNT(*) FROM [UNIVERSAL_SUB_CATEGORY_HEADINGS] WHERE [Heading_Pair_Id] >= 1000000
	UNION ALL
	SELECT COUNT(*) FROM [UNIVERSAL_SUB_CATEGORIES] WHERE [Universal_Sub_Category_Id] >= 1000000
	UNION ALL
	SELECT COUNT(*) FROM [CUSTOM_STANDARD_BASE_STANDARD]
)
SELECT SUM(RowCnt) AS TotalCustomRowCount FROM AllCustomRowCounts