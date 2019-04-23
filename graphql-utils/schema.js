const { buildSchema } = require('graphql')
const typeDefs = buildSchema(`
  type Speaker {
    _id: ID
    username: String
    name: String
    profilePicture: String
    bio: String
    role: String
    socialMedia: SocialMedia
  }
  type SocialMedia {
    twitter: String
    github: String
    linkedin: String
    instagram: String
  }
  type Query {
    speaker(username: String): Speaker
    speakers: [Speaker]
  }
  type Mutation {
    updateSpeaker(username: String): Speaker
  }
`)

module.exports.typeDefs = typeDefs
