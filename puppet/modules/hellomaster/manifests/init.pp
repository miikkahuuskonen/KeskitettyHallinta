class hellomaster {
		file { '/tmp/helloFromMaster':
			content => "This is hello from your master!\n"
			
		}
}
