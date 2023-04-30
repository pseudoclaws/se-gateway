import { generateAuthActions } from 'redux-token-auth'
import { authUrl } from './constants'

const config = {
  authUrl,
  userAttributes: {
    first_name: 'first_name',
    last_name: 'last_name',
    confirmed_at: 'confirmed_at'
  },
  userRegistrationAttributes: {
    name: 'name',
  },
}

const {
  registerUser,
  signInUser,
  signOutUser,
  verifyCredentials,
} = generateAuthActions(config)

export {
  registerUser,
  signInUser,
  signOutUser,
  verifyCredentials,
}
