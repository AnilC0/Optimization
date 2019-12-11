using JuMP,Cbc
m = Model(with_optimizer(Cbc.Optimizer))

@variable(m, 0 <= group[0:5000] <= 250,Int)  #each group can have between 0 and 250 candidate 
#for example; the group with 300 votes, 5k votes, 1 votes, 0 votes 

@expression(m, votes[i=0:5000], i*group[i])
#for example; group 5 has x votes

@constraint(m, flow[i in 1:5000], group[i-1] >= group[i])
@constraint(m, sum(group)==250)
@constraint(m, sum(votes)==5000)
@objective(m, Min, group[0])

status = optimize!(m)
for x in 0:99	#first 99 group
	println(value(group[x]))
end
