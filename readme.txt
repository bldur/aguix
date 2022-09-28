
________________________________
From: Olav Smorholm
Sent: 08 June 2016 17:25
To: Werner Riegler; Arturo Tauro; Klaus Barth; Andre Augustinus; Corrado Gargiulo; Elisa Laudi; Federico Ronchetti; Federico Antinori
Subject: ALICE computings refusal to consider GNU GuiX package manager

Dear Technical Board,

I have been trying for an extended period of time to convince O2 to seriously consider the GuiX package manager as this is now the official package manager for the GNU foundation (FSF).

Given the fact that the GNU foundation is now packaging GCC and Glibc should alone be good enough reason to use it, as nothing is more important to CERN than this.
In addition to this, it is a functional and atomic package manager giving us rollback functionality not only for individual packages, but for the system as whole.

Each "version" of a deployment is the shasum of the source files AND the shasum of the configuration input, the list of benefits that this package manager provides for the physics community is extremely long.

Here are a few of them:

* reproducible builds!
* transactional upgrades and rollbacks
* user installable packages (build daemon runs as root currently; being worked on)
* can generate a virtual machine image based on package input
* can create linux containers and run them from command line
* per user-profiles
* manage software with native manifests!
* installations are symlinked to user home folder
* two users with same config input and pkg version can safely share the build
* installed packages are immutable
* one can verify and repair the store!
* packages installed in /gnu/store outside of host OS
* does not use any of the host OS dependencies for building software
* the GNU software foundation is behind it!
* first class users of GCC and Glibc, not having to deal with redhat, sles, et.al.
* uses guile scheme as a scripting language (which is embeddable as well!)
* guile is the official scripting language of GNU and not a fashion statement
* guile is maintained by GNU as much as gcc and glibc is.
* you can "challenge" a repository/build to verify it (checking that your own local build ends up identical to what is available in the build-server/repo.
* you can publish your own builds allowing both the challenge mechanism to work, as well as sharing your own builds with other users.


In addition to this, there is an increasing frustration with the data-model group in O2.
Having to listen to arguments about wether to use char or int in the header formats, and argueing over minute details. With references to the 80's and statements about solving minor problems during compile time.

While I would actually want to aggressively exploit the benefits of guix and and just use checksums as the MagicNumber in the headers, and deal with the header format issue on a case by case basis.
As this can be achievable by ensuring that firmware and embedded linux images are managed with git and guix, allowing us to verify the entirety of O2 by just following uniqe checksums and commit id's.
Extending the concept from GuiX where software that is installed and built gets installed under /gnu/store/<checksum of configuration input and source files>-name-version.

By shamelessly exploiting this mechanism, changes can be tracked from detector changes to HLT and offline. Obviously, there needs to be a defined ontology, where detector headers doesn't end up in Offline. And there will be a need to work on parsers in order to test old data on new software and vice versa, but this is a minor problem in comparison to the current state of affairs in ALICE; to be honest, a complete mess.

Now, one complaint against this may be the fact that we are creating a rather large dependency graph of the system, however, given the fact that guix can actually generate a complete dependency graph of libraries and applications (where nothing apart from the host kernel can interfere), there is always the mechanism in GuiX called grafting:

Modifying/patching a build by "grafting" changes ontop of it, maintaining the integrity and dependency tree.

I'm sorry for sending this email around on such short notice before the technical board meeting, but I feel like this should be addressed sooner rather than later.
And I'm a bit exhausted having worked very hard on this now for a bit over a week.

Attached is a proof of concept example of guix, allowing you to test cern software with guix.
I've set up my workstation at work so that the publish and challenge mechanisms can be tested.

I'm considering extending my stay at CERN for a bit longer, but considering I have soon spent the  four weeks I have to spend on ALICE per year, and that creating this proof of concept has been hard.

I'm bringing this up to the technical board first and foremost, and haven't really spoken to people about this outside of ALICE when it comes to the data format, but I have mentioned the fact that I have packaged cern software with guix, and would like to make this more generally available.
But I will await feedback about what to do, in order to give the technical board a chance to discuss these issues.

Attached is cern.scm and a quickstart.sh script to get started.
You need to:
export GUIX_PACKAGE_PATH=/tmp/AGuiX
to be able to run e.g:

guix package -i root geant geant:4 geant4:data clhep fastjet fjcontrib cfitsio jewel hepmc lhapdf5 davix xrootd

root has enabled support for the following:
Enabled support for:  asimage astiff cxx11 cintex davix exceptions explicitlink fftw3 fitsio fortran
gviz genvector http krb5 ldap mathmore memstat minuit2 odbc opengl pgsql pythia6 pythia6_nolink python qt reflex roofit rpath shared soversion sqlite ssl thread vdt xft xml x11 xrootd

Now, there are many things missing like for example openafs etc as I currently dont have root access to an SLC machine.
As well as AliEn, aliroot etc, due to these packages being quite tricky to packages as very little is actually done in a standard way, and not only that.
Due to the many layers of build scripts and other gnarly practices, I decided to leave these things for later. As CERN grid software also have a lot of packages with very non-standard way of setting up build environments and distributing software.

I could go on, but I believe there are sufficiently many talking points already mentioned now.
I haven't been able to proof read many of these things, and have been in contact with one of the guix developers and commiting these physics packages upstream to the GNU repository and have him proof read it, but have not gotten that far just yet.

With Best Wishes,
Olav
