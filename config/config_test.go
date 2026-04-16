package config

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestGetConfig(t *testing.T) {
	_, err := GetConfig()
	require.NoError(t, err)

	var env environment = "abc"
	SwitchEnvironment(env)

	cfg, err := GetConfig()
	require.NoError(t, err)
	assert.Equal(t, env, cfg.App.Environment)
}
