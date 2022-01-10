# APK-Method-Tracker
## How It Works
![op1](https://user-images.githubusercontent.com/65654501/148697278-7d705787-68ef-4b2c-88c6-fe6021858552.png)
![op2](https://user-images.githubusercontent.com/65654501/148697716-522caf7b-540a-4d4f-82c6-ba66ed485de3.png)
### Use Case
#### Step 1
Open the modified app.
Do something in the app.
#### Step 2
Check the log folder<br>
![image](https://user-images.githubusercontent.com/65654501/148726267-cbffcc9b-fec4-4d6a-acdd-3a843a2c9192.png)<br>
Each file's name has the following meaning:
[{The class name}]--{method name}({parameter}){method type (e.g., Z = boolean, V = void}
#### Step 3
Investigate the decompiled and translated code<br>
![image](https://user-images.githubusercontent.com/65654501/148731679-8d4261f8-9552-457c-b0f5-ae8969ae8d9e.png)<br>
Make use of "search in content"<br>
Rule: if there is a logger20200108() call, the method is under the detection, vice versa.
## Installation

## Guidelines & Tips
### Suggested test plan
#### Case: You sure the entry point equals the first activity that the app starts
1st test:<br>
Depth = 1 scan<br>
Method filter = V<br>
<br>

2nd test if not satisfied with previous:<br>
Depth = 2 scans<br>
Method filter = V + any types that you interested in/No filter<br>

Max depth is not suggested, the app might crash. It also makes the trace harder to understand.
#### Case: You not sure...
Depth = -1 (full scan)<br>
Method filter = V<br>
