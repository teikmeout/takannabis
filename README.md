# Takannabis

## How to run this app
1. `npm i`
2. `createdb takannabis`
3. `psql -d takannabis -f dbSetup/schema.sql`
4. `npm start`

## Security approach for this application
Express Backend  
- Bcryptjs 
- JWT token

React Frontend  
- cookies
- localstorage? / client can view and modify LS!! no bueno


