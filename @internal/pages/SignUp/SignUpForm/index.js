import React, {useState, useEffect} from "react";
import {Pane} from "evergreen-ui";
import {TextInput} from "evergreen-ui";
import {connect} from "react-redux";
import get from "@unction/get";
import view from "@internal/view";

export default view([
  connect(
    get("signUpForm"),
    ({signUpForm: {write}}) => ({write}),
  ),
  function SignUpForm ({email, password, write}) {
    const [form, setForm] = useState({email, password});

    useEffect(function writeEmailState () {
      write(form);
    }, [form]);

    return <form>
      <Pane>
        {form.email}
        <TextInput type="email" onChange={(event) => setForm({email: event.target.value})} value={email} />
      </Pane>
      <Pane>
        {form.password}
        <TextInput type="password" onChange={(event) => setForm({password: event.target.value})} value={password} />
      </Pane>
    </form>;
  },
]);
