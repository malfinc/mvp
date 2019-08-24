import facepaint from "facepaint";

const primary = "rgba(255, 97, 190, 1)";
const neutral = "rgba(255, 254, 245, 1)";
const dark = "rgba(180, 91, 113, 1)";
const secondaryText = "rgba(75, 75, 75, 0.85)";
const inverseLink = "rgba(197,239,247, 1)";
const mediaqueries = facepaint([
  // Extra small devices (portrait phones, less than 576px)
  "@media(min-width: 576px)",
  // Medium devices (tablets, 768px and up)
  "@media(min-width: 768px)",
  // Large devices (desktops, 992px and up)
  "@media(min-width: 992px)",
  // Extra large devices (large desktops, 1200px and up)
  "@media(min-width: 1200px)",
]);

export {
  primary,
  neutral,
  dark,
  secondaryText,
  inverseLink,
  mediaqueries,
};
