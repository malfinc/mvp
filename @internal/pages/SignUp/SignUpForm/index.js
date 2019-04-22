import React, {useState, useEffect} from "react";
import {Pane} from "evergreen-ui";
import {TextInput} from "evergreen-ui";
import {connect} from "react-redux";
import get from "@unction/get";
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
]);
