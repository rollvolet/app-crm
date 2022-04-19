SET QUOTED_IDENTIFIER ON
GO

UPDATE TblIntervention
SET PlanningDate = v.[Date]
FROM TblIntervention i
INNER JOIN TblPlanningEvent v ON v.InterventionId = i.Id
GO

SET QUOTED_IDENTIFIER OFF
GO
