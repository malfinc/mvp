import React, {useState} from "react";
import {useDispatch} from "react-redux";

import {Field} from "@internal/elements";

export default function SignUpForm () {
  const dispatch = useDispatch();
  const [loading, setLoading] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const submitForm = async (event) => {
    event.preventDefault();
    setLoading(true);
    await dispatch({type: "resources/write", payload: 1});
    setLoading(false);
  };

  return <form id="signUpForm" onSubmit={submitForm}>
    <Field scope="signUpForm" attribute="email" type="email" label="Email" autoComplete="email" readOnly={loading} onChange={(event) => setEmail(event.target.value)} value={email} />
    <Field scope="signUpForm" attribute="password" type="password" label="Password" autoComplete="new-password" readOnly={loading} onChange={(event) => setPassword(event.target.value)} value={password} />
    <section>
      <button className="btn btn-primary" type="submit">Sign Up</button>
    </section>
  </form>;
}
