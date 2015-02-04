class List
  constructor: ()->
    @_list = []
  add: (args...)->
    @_list.push args
  get: ()->
    return @_list

APIList = new List()
#Users
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Users/me'
APIList.add '/Users/update'
APIList.add '/Users/updatePicture',             ['profile_image']
APIList.add '/Users/getKarmaStats'

#Real time notifications
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Realtime/getUserChannel'

#Timeline
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Timeline/getPlurk',               ['plurk_id']
APIList.add '/Timeline/getPlurks'
APIList.add '/Timeline/getUnreadPlurks'
APIList.add '/Timeline/getPublicPlurks',        ['user_id']
APIList.add '/Timeline/plurkAdd',               ['content', 'qualifier'],              {'qualifier' : 'qualifier'},  {'qualifier' : ':'}
APIList.add '/Timeline/plurkDelete',            ['plurk_id']
APIList.add '/Timeline/plurkEdit',              ['plurk_id', 'content']
APIList.add '/Timeline/toggleComments',         ['plurk_id', 'no_comments']
APIList.add '/Timeline/mutePlurks',             ['ids']
APIList.add '/Timeline/unmutePlurks',           ['ids']
APIList.add '/Timeline/favoritePlurks',         ['ids']
APIList.add '/Timeline/unfavoritePlurks',       ['ids']
APIList.add '/Timeline/replurk',                ['ids']
APIList.add '/Timeline/unreplurk',              ['ids']
APIList.add '/Timeline/markAsRead',             ['ids']
APIList.add '/Timeline/uploadPicture',          ['image']
APIList.add '/Timeline/reportAbuse',            ['plurk_id', 'categoty']

#Polling
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Polling/getPlurks',               ['offset']
APIList.add '/Polling/getUnreadCount'

#Timeline
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Responses/get',                   ['plurk_id']
APIList.add '/Responses/responseAdd ',          ['plurk_id', 'content', 'qualifier'],  {'qualifier' : 'qualifier'},  {'qualifier' : ':'}
APIList.add '/Responses/responseDelete',        ['response_id', 'plurk_id']

#Responses
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Profile/getOwnProfile'
APIList.add '/Profile/getPublicProfile',        ['user_id']

#Profile
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/FriendsFans/getFriendsByOffset',  ['user_id']
APIList.add '/FriendsFans/getFansByOffset',     ['user_id']
APIList.add '/FriendsFans/getFollowingByOffset'
APIList.add '/FriendsFans/becomeFriend',        ['friend_id']
APIList.add '/FriendsFans/removeAsFriend',      ['friend_id']
APIList.add '/FriendsFans/becomeFan',           ['fan_id']
APIList.add '/FriendsFans/setFollowing',        ['user_id', 'follow']
APIList.add '/FriendsFans/getCompletion'

#Friends and fans
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Alerts/getActive'
APIList.add '/Alerts/getHistory'
APIList.add '/Alerts/addAsFan',                 ['user_id']
APIList.add '/Alerts/addAllAsFan',
APIList.add '/Alerts/addAllAsFriends'
APIList.add '/Alerts/addAsFriend',              ['user_id']
APIList.add '/Alerts/denyFriendship',           ['user_id']
APIList.add '/Alerts/removeNotification',       ['user_id']


#Search
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/PlurkSearch/search',              ['query']
APIList.add '/UserSearch/search',               ['query']

#Emoticons
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Emoticons/get'

#Blocks
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Blocks/get'
APIList.add '/Blocks/block',                    ['user_id']
APIList.add '/Blocks/unblock',                  ['unblock']

#Cliques'
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/Cliques/getCliques'
APIList.add '/Cliques/getClique',               ['clique_name']
APIList.add '/Cliques/createClique',            ['clique_name']
APIList.add '/Cliques/renameClique',            ['clique_name', 'new_name']
APIList.add '/Cliques/add',                     ['clique_name', 'user_id']
APIList.add '/Cliques/remove',                  ['clique_name', 'user_id']

#PlurkTop
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/PlurkTop/getCollections'
APIList.add '/PlurkTop/getTopics'
APIList.add '/PlurkTop/getPlurks',              ['collection_name']


#OAuth Utilities
#          |--------API path-------------------|----------require parameter----------|-----default from config-----|----method default----|
APIList.add '/checkToken'
APIList.add '/expireToken'
APIList.add '/checkTime'
APIList.add '/echo',                            ['data']

module.exports = APIList.get()