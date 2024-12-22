import { InvalidActionError } from "../../errors/validation.js";
import * as Validation from "../validation.validator.js";
import type { RegisterUser } from "./register-user.js";

/**
 * The details needed to create a new lobby.
 */
export interface CreateLobby {
  /**
   * The name of the lobby.
   */
  name: string;
  /**
   * The registration for the owner of the lobby.
   */
  owner: RegisterUser;
}

const _validateCreateLobby = Validation.validate("CreateLobby");
export const validate = (action: object): CreateLobby => {
  try {
    return _validateCreateLobby(action);
  } catch (e) {
    const error = e as Error;
    throw new InvalidActionError(error.message);
  }
};
