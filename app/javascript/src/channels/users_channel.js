import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('UsersChannel', {
  received (data) {
    console.log(data)
    if (data.cableReady) CableReady.perform(data.operations)
  }
})
