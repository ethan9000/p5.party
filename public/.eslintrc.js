/* eslint-env node */
module.exports = {
  parserOptions: {
    sourceType: "script",
  },
  globals: {
    party: "readonly",
    partyConnect: "readonly",
    partyLoadShared: "readonly",
    partySetShared: "readonly",
    partyWatchShared: "readonly",
    partyIsHost: "readonly",
    partyLoadMyShared: "readonly",
    partyLoadParticipantShareds: "readonly",
    partySubscribe: "readonly",
    partyEmit: "readonly",
    partyToggleInfo: "readonly",
  },
  rules: {
    "prefer-destructuring": "off",
    "no-unused-vars": [
      "error",
      {
        vars: "all",
        args: "none",
        varsIgnorePattern:
          "\\b(preload|setup|draw|keyPressed|keyReleased|keyTyped|mouseMoved|mouseDragged|mousePressed|mouseReleased|mouseClicked|doubleClicked|mouseWheel|touchStarted|touchMoved|touchEnded)\\b",
      },
    ],
    "no-console": 0,
  },
};
