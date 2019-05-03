import React, {useState} from "react";
import useDebounce from "react-use/lib/useDebounce";
import {Pane} from "evergreen-ui";
import {TextInput} from "evergreen-ui";
import {Button} from "evergreen-ui";
import {connect} from "react-redux";
import {get} from "@unction/complete";
import view from "@internal/view";

export default view([
  connect(
    get("signUpForm"),
    ({signUpForm: {mergeAttributes, submitForm}}) => ({mergeAttributes, submitForm}),
  ),
  function SignUpForm ({mergeAttributes, submitForm}) {
    const [formFields, setFormFields] = useState({});
    const [loading, setLoading] = useState(false);
    const {email} = formFields;
    const onChangeEmail = (event) => setFormFields({...formFields, email: event.target.value});
    const onSubmit = async () => {
      try {
        setLoading(true);
        await submitForm();
      } finally {
        setLoading(false);
      }
    };

    useDebounce(function mergeState () {
      mergeAttributes(formFields);
    }, 250, [formFields]);

    return <form id="signUpForm" onSubmit={onSubmit}>
      <Pane>
        <TextInput id="signUpFormEmail" name="signUpForm[email]" type="email" disabled={loading} onChange={onChangeEmail} value={email} />
      </Pane>
      <Pane>
        <Button appearance="primary" isLoading={loading}>Sign Up</Button>
      </Pane>
    </form>;
  },
]);
