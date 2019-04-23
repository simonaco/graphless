const resolvers = {
  speaker: async (obj, args, context, info) => {
    const Speakers = args.client.collection('speakers')
    return await Speakers.findOne({ username: obj.username })
  },
  speakers: async (obj, args, context, info) => {
    const Speakers = args.client.collection('speakers')
    return await Speakers.find({}).toArray()
  },
  updateSpeaker: async (obj, args, context, info) => {
    const Speakers = args.client.collection('speakers')
    return await Speakers.findOne({ username: obj.username })
  },
}

module.exports.resolvers = resolvers
