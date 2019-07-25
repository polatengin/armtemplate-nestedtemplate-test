# armtemplate-with-nestedtemplates

This repo is for Testing ARM Nested Templates

After cloning the repo you just need to invoke `publish.ps1` *PowerShell script* just like below;

```bash
.\publish.ps1
```

*Script* will ask you following questions;

* Please enter Resource Group Name
* Please enter the beginning of the Azure Functions names
* Please enter how many Azure Function you want

It'll create a resource group in your *Azure Subscription*

It'll create *Azure Function* as many as you wanted

It'll compile and publish the `appcode` project to all of the functions
