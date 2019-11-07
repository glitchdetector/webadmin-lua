# FiveM Webadmin Lua Plugin Factory

### This resource aims to provide helper functions to Lua for generating Webadmin plugins.

## Contents

The export `getFactory` which contains widget helpers and factories.

Included are two files:

 - `server/included/boilerplate.lua`, a boilerplate structure file
 - `server/included/demo.lua`, a showcase / demo of features

Both provide a starting step for how to use this system.

They can be enabled in the `__resource.lua` file if you want to preview them in the webadmin interface. Make sure you are logged in and have the `webadmin` ACE permission.

## Getting started

Please read the `server/included/demo.lua` file for an in-depth look at the available features, and the code behind it all.

Use `server/included/boilerplate.lua` to start creating your own plugins.

## Creating your own plugin

A plugin can be contained in its own resource, you can also add the plugin code to existing resources.
A resource can have multiple plugins, there's no inherent limit.

1. Create a resource as you would normally.
2. In the `__resources.lua` file, add `dependency 'webadmin-lua'`
3. Create a copy of `server/included/boilerplate.lua` and run it as a server script.
4. Edit the `CreatePage` function to produce the page you want to see.

You can freely restart your resource without worrying about duplicate pages, Webadmin automatically handles plugin data for you.

## Disclaimer

This project is not supposed to be a one-and-only solution to Webadmin plugins, it's merely a simple solution for creating plugins in Lua. Its main goal is to provide widget generation with a simple API. The boilerplate setup makes it easier to get started.

Most widget layouts are taken from the CoreUI documentation.

Do not re-upload or remix this, link to this repository instead if you create a plugin that depends on the resource.

## Contributons

Contributions and feedback are highly wanted!
