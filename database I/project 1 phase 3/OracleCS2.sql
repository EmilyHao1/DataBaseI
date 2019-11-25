SELECT *  FROM Forms 
natural join (select Reps.RepID, Accounts.Name as RepName 
            From Reps inner Join Accounts 
            on Reps.loginName = Accounts.loginName)
natural Join (select distinct Accounts.name as AgentName From Process 
            inner join Agents
            On Agents.TtbID = Process.TTBID 
            inner join Accounts 
            On Agents.TtbID = Process.TTBID 
            inner join Forms 
            on Forms.formID = process.formID 
            where Forms.formID = 100)
inner Join Wines on Forms.wineID = Wines.wineID 
WHERE Forms.formID = 100;


select * from Forms 
natural join (select RepID, Accounts.Name as RepName 
            From Reps inner Join Accounts 
            on Reps.loginName = Accounts.loginName) 
natural join 
(select distinct Accounts.name as AgentName From Process 
            inner join Agents
            On Agents.TtbID = Process.TTBID 
            inner join Accounts 
            On Agents.TtbID = Process.TTBID); 