package cmd

import (
	"github.com/spf13/cobra"
	flag "github.com/spf13/pflag"

	"github.com/mesosphere/konvoy-image-builder/pkg/app"
)

var (
	vsphereExample = "vsphere --datacenter dc1 --cluster zone1 --datastore nfs-store1 --network public --template=d2iq-base-templates/d2iq-base-CentOS-7.9 images/ami/centos-79.yaml"
	vsphereUse     = "vsphere <image.yaml>"
)

func NewVSphereBuildCmd() *cobra.Command {
	flags := &buildCLIFlags{}
	cmd := &cobra.Command{
		Use:     vsphereUse,
		Short:   "build and provision vsphere images",
		Example: vsphereExample,
		Args:    cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			runBuild(args[0], flags)
		},
	}

	initBuildVSphereFlags(cmd.Flags(), flags)
	return cmd
}

func NewVSphereGenerateCmd() *cobra.Command {
	flags := &generateCLIFlags{}
	cmd := &cobra.Command{
		Use:     vsphereUse,
		Short:   "generate files relating to building vsphere images",
		Example: vsphereExample,
		Args:    cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			runGenerate(args[0], flags)
		},
	}

	initGenerateVSphereFlags(cmd.Flags(), flags)
	return cmd
}

func initBuildVSphereFlags(fs *flag.FlagSet, buildFlags *buildCLIFlags) {
	initGenerateArgs(fs, &buildFlags.generateCLIFlags)
	initVSphereArgs(fs, &buildFlags.generateCLIFlags)

	addBuildArgs(fs, buildFlags)
}

func initGenerateVSphereFlags(fs *flag.FlagSet, generateFlags *generateCLIFlags) {
	initGenerateArgs(fs, generateFlags)
	initVSphereArgs(fs, generateFlags)
}

func initVSphereArgs(fs *flag.FlagSet, gFlags *generateCLIFlags) {
	gFlags.userArgs.VSphere = &app.VSphereArgs{}
	addVSphereArgs(fs, gFlags.userArgs.VSphere)
}

func addVSphereArgs(fs *flag.FlagSet, vsphereArgs *app.VSphereArgs) {
	fs.StringVar(
		&vsphereArgs.Template,
		"template",
		"",
		"Base template to be used. Can include folder. <templatename> or <folder>/<templatename> (REQUIRED)",
	)
	fs.StringVar(
		&vsphereArgs.Datacenter,
		"datacenter",
		"",
		"vSphere datacenter (REQUIRED)",
	)

	fs.StringVar(
		&vsphereArgs.Cluster,
		"cluster",
		"",
		"vSphere cluster to be used. Alternatively set host (REQUIRED) ",
	)

	fs.StringVar(
		&vsphereArgs.Host,
		"host",
		"",
		"vSphere host to be used. Alternatively set cluster (REQUIRED)",
	)
	fs.StringVar(
		&vsphereArgs.Datastore,
		"datastore",
		"",
		"datastore used to build and store the KIB image (REQUIRED)",
	)
	fs.StringVar(
		&vsphereArgs.Network,
		"network",
		"",
		"vSphere network to start KIB build; KIB expects DHCP on this network; Ensure the machine running KIB has access to this network (REQUIRED)",
	)
	fs.StringVar(
		&vsphereArgs.Folder,
		"folder",
		"",
		"deploy KIB image into this folder",
	)
	fs.StringVar(
		&vsphereArgs.ResourcePool,
		"resource-pool",
		"",
		"vSphere resource pool to be used to build KIB image",
	)

	fs.StringVar(
		&vsphereArgs.ResourcePool,
		"ssh-privatekey-file",
		"",
		"path to ssh private key which will be used to loginto the template",
	)

	fs.StringVar(
		&vsphereArgs.ResourcePool,
		"ssh-publickey",
		"",
		"SSH public key which will be deployed using cloud-init. Ensure to set ssh-privatekey-file or load the private key into ssh-agent",
	)

	fs.StringVar(
		&vsphereArgs.SSHUserName,
		"ssh-username",
		"",
		"Username to be used with the vSphere template",
	)
}