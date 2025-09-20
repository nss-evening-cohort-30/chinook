# Chinook Database Workshop

This SQL workshop provides hands-on, instructor-led practice for building queries on a PostgreSQL database. By the end of the workshop, students should be able to:  

- Read and interpret an ERD to inform query building  
- Select all columns or specific fields from a table  
- Identify which tables to join to answer a given prompt  
- Understand the differences between `JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `INNER JOIN`  
- Use `GROUP BY`, `COUNT`, and `ORDER BY` effectively  
- Apply functions such as `CONCAT` and `SUM` in queries  
- Develop a systematic approach for constructing queries to solve any given problem  

## Getting Started

#### To run this workshop you will need: 
- [PostgreSQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- The [PostgreSQL extension](https://marketplace.visualstudio.com/items?itemName=ckolkman.vscode-postgres) for VS Code

### Setup
1. **Instructors:** Click **Use this template** and create it in your cohort's organization
**Students:** Follow along from step 2
2. Clone this repo and navigate to the repo directory
```shell
git clone git@github.com:nashville-software-school-workshops/chinook.git
cd chinook
```
3. Create the database and tables with the `Chinook_PostgreSql.sql` script
```shell
# Replace your_username with your psql username. This is likely the username of your operating system
# If you are unsure of your operating system username, run the command: whoami
psql -U your_username -f Chinook_PostgreSql.sql
```

You should see the following output:
```shell
...
INSERT 0 18
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 1000
INSERT 0 715
```
4.  Open the repo in VS CODE and open the PostgreSQL Explorer extension. (It's the elephant icon in the tabs on the left of the window).
5.  Click the plus icon to add a Database Connection. 
6.  For hostname enter `localhost`
7.  For user enter the username you used for step 2
8.  If you set up a password for your postgres user enter it here, if not leave it blank
9.  Port should be `5432`
10.  Choose `Standard Connection`
11. You should see `chinook` listed in the available options. Choose `chinook`.
12. For the display name, call it `chinook`

You are now connected to your database!

### Running Queries

1. Be sure to have the students review the [ERD](./erd/chinook_erd.png) before beginning the workshop. Copy the file and paste it in their slack channel.
1. Open `exercises.sql`. At the bottom left-hand corner of the VS Code window, click **Select Postgres Server** and choose `chinook` -> `chinook`
2. **Instructors:** Feel free to review the `completed_exercises.sql` file before beginning the workshop. Follow the prompts in `exercises.sql` and generate the queries with the students, helping them to understand and meet the learning objectives defined above. It's unlikely you will get through all the prompts. Push up the queries you and your students worked through together and encourage them to follow the steps in this readme to set it up on their own machine and complete the remaining prompts on their own.
**Students:** Complete the remaining prompts in `exercise.sql`. Continue to reference the [ERD](./erd/chinook_erd.png). If you *and* your teammates get stuck, take a look at `completed_exercises.sql` but try not to use it as a crutch. 
3. To run a query, highlight the single query, right click, and select **run query**