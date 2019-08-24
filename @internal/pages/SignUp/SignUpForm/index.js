import React, {useState} from "react";
import useDebounce from "react-use/lib/useDebounce";
import {connect} from "react-redux";
import view from "@internal/view";

export default view([
  connect(),
  function SignUpForm (props) {
    const {dispatch} = props;
    const {signUpForm} = dispatch;
    const {mergeAttributes, submitForm} = signUpForm;
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
      <section>
        <TextInput id="signUpFormEmail" name="signUpForm[email]" type="email" disabled={loading} onChange={onChangeEmail} value={email} />
      </section>
      <section>
        <Button appearance="primary" isLoading={loading}>Sign Up</Button>
      </section>
    </form>;
  },
]);
