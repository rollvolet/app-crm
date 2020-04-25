UPDATE dbo.TblIntervention
SET Description = i.Comment
FROM dbo.TblIntervention AS [i]

UPDATE dbo.TblIntervention
SET Comment = NULL
FROM dbo.TblIntervention AS [i]
