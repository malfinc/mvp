import React from "react";
import {withState} from "recompose";
import {withHandlers} from "recompose";
import {Pane} from "evergreen-ui";
import {TextInput} from "evergreen-ui";
import {connect} from "react-redux";
import get from "@unction/get";
import pipe from "@unction/pipe";

import view from "@internal/view";

export default view([
  function SignUpForm ({setEmail, email}) {
    return <form>
      <Pane>
        <TextInput onChange={setEmail} value={email} />
      </Pane>
    </form>;
  },
  connect(
    get("signUpForm"),
    pipe([get("signUpForm")]),
  ),
  withState("email", "setStateEmail", ""),
  withHandlers({
    setEmail: ({setStateEmail}) => (event) => setStateEmail(event.target.value),
  }),
]);
