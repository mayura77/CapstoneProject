const express = require('express');
const app = express();

app.get('/', (req,res)=>{
res.send(`
<h1>DevOps Capstone Project</h1>
<h3>Group Members</h3>
<ul>
<li>Sabin - Terraform</li>
<li>Kshitiz - Docker and Kubernetes</li>
<li>Mayura - CI/CD</li>
</ul>
`);
});

app.listen(3000,()=>{
console.log("Running on port 3000");
});
