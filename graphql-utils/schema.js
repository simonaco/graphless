const { buildSchema } = require('graphql')
const typeDefs = buildSchema(`
  type Query {
    hello(name:String):String
  }
  type Mutation {
    insertCity(name: String): String
  }
`)

module.exports.typeDefs = typeDefs
